<?php
include 'connection.php';

if ($_SERVER["REQUEST_METHOD"] == "POST") {

    $name     = trim($_POST['name']);
    $email    = trim($_POST['email']);
    $password = $_POST['password'];
    $confirm  = $_POST['confirm_password'];
    $phone    = trim($_POST['phone']);
    $address  = trim($_POST['address']);
    $locality = trim($_POST['locality']);

    // 1️⃣ Check password match
    if ($password !== $confirm) {
        die("Passwords do not match!");
    }

    // 2️⃣ Hash password
    $hashed_password = password_hash($password, PASSWORD_DEFAULT);

    // 3️⃣ Check if email already exists
    $check = $conn->prepare("SELECT id FROM tblcustomers WHERE email = ?");
    $check->bind_param("s", $email);
    $check->execute();
    $check->store_result();

    if ($check->num_rows > 0) {
        die("Email already registered!");
    }

    // 4️⃣ Insert data securely
    $stmt = $conn->prepare("
        INSERT INTO tblcustomers 
        (name, email, password, phone, address, locality)
        VALUES (?, ?, ?, ?, ?, ?)
    ");

    $stmt->bind_param("ssssss", 
        $name, 
        $email, 
        $hashed_password, 
        $phone, 
        $address, 
        $locality
    );

    if ($stmt->execute()) {
        echo "Customer registered successfully!";
    } else {
        echo "Error: " . $stmt->error;
    }

    $stmt->close();
    $conn->close();
}
?>
