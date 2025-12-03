<?php
// api/create_booking.php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");
header("Access-Control-Allow-Methods: POST");

include '../connection.php';

$data = json_decode(file_get_contents("php://input"));

// 1. Validation
if (
    !isset($data->customer_id) || 
    !isset($data->provider_id) || 
    !isset($data->service_id) || 
    !isset($data->date) || 
    !isset($data->time_slot) ||
    !isset($data->address)
) {
    echo json_encode(["status" => "error", "message" => "Missing required fields"]);
    exit;
}

// 2. Prevent Booking in the Past
$bookingDate = strtotime($data->date);
$today = strtotime(date("Y-m-d"));
if ($bookingDate < $today) {
    echo json_encode(["status" => "error", "message" => "Cannot book for a past date"]);
    exit;
}

// 3. (Optional) Check Availability
// You could run a SELECT here to see if the provider is already booked at this time.
// For now, we will allow overlaps for simplicity.

// 4. Insert Booking
$sql = "INSERT INTO tblbookings (customer_id, provider_id, service_id, booking_date, time_slot, address, status) VALUES (?, ?, ?, ?, ?, ?, 'pending')";

$stmt = $conn->prepare($sql);
$stmt->bind_param("iissss", 
    $data->customer_id, 
    $data->provider_id, 
    $data->service_id, 
    $data->date, 
    $data->time_slot,
    $data->address
);

if ($stmt->execute()) {
    echo json_encode(["status" => "success", "booking_id" => $conn->insert_id]);
} else {
    echo json_encode(["status" => "error", "message" => "Database Error: " + $stmt->error]);
}

$stmt->close();
$conn->close();
?>