<?php
// api/update_profile.php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");
header("Access-Control-Allow-Methods: POST");
header("Access-Control-Allow-Headers: Content-Type, Access-Control-Allow-Headers, Authorization, X-Requested-With");

include '../connection.php';

$data = json_decode(file_get_contents("php://input"));

if (!isset($data->id) || !isset($data->name) || !isset($data->phone)) {
    echo json_encode(["status" => "error", "message" => "Missing required fields"]);
    exit;
}

$id = $data->id;
$name = $data->name;
$phone = $data->phone;
$address = isset($data->address) ? $data->address : "";

// Update Query (Assuming table is 'tblcustomers')
$sql = "UPDATE tblcustomers SET name=?, phone=?, address=? WHERE id=?";
$stmt = $conn->prepare($sql);
$stmt->bind_param("sssi", $name, $phone, $address, $id);

if ($stmt->execute()) {
    // Return the updated user data so frontend can update localStorage
    // Fetch fresh data
    $result = $conn->query("SELECT id, name, email, phone, address, profile_img, role FROM tblcustomers WHERE id=$id");
    $updatedUser = $result->fetch_assoc();
    // Add role manually if not in DB column or consistent with login
    if(!isset($updatedUser['role'])) $updatedUser['role'] = 'customer'; 
    
    echo json_encode(["status" => "success", "message" => "Profile updated", "user" => $updatedUser]);
} else {
    echo json_encode(["status" => "error", "message" => "Update failed: " . $stmt->error]);
}

$stmt->close();
$conn->close();
?>