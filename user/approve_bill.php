<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json");
header("Access-Control-Allow-Methods: POST");
include '../connection.php';

$data = json_decode(file_get_contents("php://input"));

if(!isset($data->booking_id)) {
    echo json_encode(["status" => "error", "message" => "ID missing"]);
    exit;
}

// 1. Get Details to Calculate Commission
$id = $data->booking_id;
$q = $conn->query("SELECT final_amount, provider_id FROM tblbookings WHERE id = $id");
$row = $q->fetch_assoc();

$amount = $row['final_amount'];
$provider_id = $row['provider_id'];

// 2. Logic: 10% Commission
$admin_share = $amount * 0.10;
$provider_share = $amount - $admin_share;

// 3. Mark as Completed
$update = $conn->query("UPDATE tblbookings SET status='completed', completed_at=NOW() WHERE id=?");
    
if($update) {
    // 4. Record Transaction (Optional but recommended)
    $stmt = $conn->prepare("INSERT INTO tbltransactions (booking_id, total_amount, admin_commission, provider_earnings) VALUES (?, ?, ?, ?)");
    $stmt->bind_param("iddd", $id, $amount, $admin_share, $provider_share);
    $stmt->execute();

    echo json_encode(["status" => "success", "message" => "Payment Successful!"]);
} else {
    echo json_encode(["status" => "error", "message" => "Update Failed"]);
}
?>