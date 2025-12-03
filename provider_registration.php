<?php
include 'connection.php';

if ($_SERVER["REQUEST_METHOD"] === "POST") {

    $name      = trim($_POST['name']);
    $email     = trim($_POST['email']);
    $password  = $_POST['password'];
    $confirm   = $_POST['confirm_password'];
    $phone     = trim($_POST['phone']);
    $city      = trim($_POST['city']);
    $bio       = trim($_POST['bio']);
    $profession = trim($_POST['profession']);
    $experience = intval($_POST['experience_years']);

    // 1️⃣ Password match check
    if ($password !== $confirm) {
        die("Passwords do not match!");
    }

    // 2️⃣ Hash password securely
    $hashed_password = password_hash($password, PASSWORD_DEFAULT);

    // 3️⃣ Check if email already exists
    $check = $conn->prepare("SELECT id FROM tblproviders WHERE email = ?");
    $check->bind_param("s", $email);
    $check->execute();
    $check->store_result();

    if ($check->num_rows > 0) {
        die("Email already registered!");
    }

    // 4️⃣ Insert provider data securely
    $stmt = $conn->prepare("
        INSERT INTO tblproviders 
        (name, email, password, phone, city, bio, profession, experience_years)
        VALUES (?, ?, ?, ?, ?, ?, ?, ?)
    ");

    $stmt->bind_param("sssssssi",
        $name,
        $email,
        $hashed_password,
        $phone,
        $city,
        $bio,
        $profession,
        $experience
    );

    if ($stmt->execute()) {
        echo "Provider registration successful!";
    } else {
        echo "Error: " . $stmt->error;
    }

    $stmt->close();
    $conn->close();
}
?>
