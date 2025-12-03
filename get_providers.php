<?php
header("Content-Type: application/json");
header("Access-Control-Allow-Origin: *");

include "connection.php";

$sql = "SELECT id, name, profession, experience_years, city, profile_img 
        FROM tblproviders 
        ORDER BY id DESC 
        LIMIT 5"; 

$res = $conn->query($sql);

$data = [];

while ($row = $res->fetch_assoc()) {
    $data[] = $row;
}

echo json_encode([
    "status" => true,
    "providers" => $data
]);

$conn->close();
?>
