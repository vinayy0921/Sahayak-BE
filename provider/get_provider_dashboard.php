<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");
include '../connection.php';

$provider_id = $_GET['provider_id'];
// echo $provider_id;

// 1. Get Stats (Earnings & Total Jobs)
$statsSql = "SELECT 
    COUNT(CASE WHEN status='completed' THEN 1 END) as total_jobs,
    COALESCE(SUM(CASE WHEN status='completed' THEN 
        (SELECT price_per_hour FROM tblprovider_services WHERE id=tblbookings.service_id) 
    END), 0) as total_earnings
    FROM tblbookings WHERE provider_id = ?";

$stmt = $conn->prepare($statsSql);
$stmt->bind_param("i", $provider_id);
$stmt->execute();
$stats = $stmt->get_result()->fetch_assoc();

// 2. Get New Requests (Pending)
$reqSql = "SELECT b.id, b.booking_date, b.time_slot, b.address, c.name as customer_name, ps.service_name, ps.price_per_hour 
           FROM tblbookings b 
           JOIN tblcustomers c ON b.customer_id = c.id
           JOIN tblprovider_services ps ON b.service_id = ps.id
           WHERE b.provider_id = ? AND b.status = 'pending'
           ORDER BY b.booking_date ASC";
$stmt = $conn->prepare($reqSql);
$stmt->bind_param("i", $provider_id);
$stmt->execute();
$requests = $stmt->get_result()->fetch_all(MYSQLI_ASSOC);

// 3. Get Upcoming Jobs (Confirmed)
$jobSql = "SELECT b.id, b.booking_date, b.time_slot, b.address, c.name as customer_name, c.phone, ps.service_name 
           FROM tblbookings b 
           JOIN tblcustomers c ON b.customer_id = c.id
           JOIN tblprovider_services ps ON b.service_id = ps.id
           WHERE b.provider_id = ? AND b.status = 'confirmed'
           ORDER BY b.booking_date ASC";
$stmt = $conn->prepare($jobSql);
$stmt->bind_param("i", $provider_id);
$stmt->execute();
$upcoming = $stmt->get_result()->fetch_all(MYSQLI_ASSOC);

echo json_encode(["status" => "success", "stats" => $stats, "requests" => $requests, "upcoming" => $upcoming]);
?>