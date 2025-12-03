<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");

include '../connection.php';

$customer_id = isset($_GET['customer_id']) ? $_GET['customer_id'] : '';

if(empty($customer_id)) {
    echo json_encode([]);
    exit;
}

// Join Bookings + Service Details + Provider Details
$sql = "
    SELECT 
        b.id as booking_id,
        b.booking_date,
        b.time_slot,
        b.status,
        b.address,
        b.created_at,
        ps.service_name,
        ps.price_per_hour,
        p.name as provider_name,
        p.profile_img,
        p.phone as provider_phone
    FROM tblbookings b
    JOIN tblprovider_services ps ON b.service_id = ps.id
    JOIN tblproviders p ON b.provider_id = p.id
    WHERE b.customer_id = ?
    ORDER BY b.booking_date DESC, b.time_slot DESC
";

$stmt = $conn->prepare($sql);
$stmt->bind_param("i", $customer_id);
$stmt->execute();
$result = $stmt->get_result();

$bookings = [];
while ($row = $result->fetch_assoc()) {
    // Fix image path logic here if needed, or handle in frontend
    $bookings[] = $row;
}

echo json_encode($bookings);
?>