<?php
// api/search.php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");

include '../connection.php';

$query = isset($_GET['q']) ? $_GET['q'] : '';

if(empty($query)) {
    echo json_encode([]); // Return empty array if no query
    exit;
}

$searchTerm = "%" . $query . "%";

// Search in 'provider_services' and join with 'providers' to get names
// We search by Service Name (e.g., "Plumber") or Provider Name (e.g., "Ravi")
$sql = "SELECT 
            ps.id, 
            p.id as provider_id,
            ps.service_name, 
            ps.price_per_hour, 
            ps.description,
            p.name as provider_name, 
            p.profile_img, 
            p.city, 
            p.is_verified
        FROM tblprovider_services ps
        JOIN tblproviders p ON ps.provider_id = p.id
        WHERE ps.service_name LIKE ? OR p.name LIKE ? OR p.city LIKE ?";

$stmt = $conn->prepare($sql);
$stmt->bind_param("sss", $searchTerm, $searchTerm, $searchTerm);
$stmt->execute();
$result = $stmt->get_result();

$services = [];
while ($row = $result->fetch_assoc()) {
    $services[] = $row;
}

echo json_encode($services);
?>