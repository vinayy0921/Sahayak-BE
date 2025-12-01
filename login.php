<?php
session_start();
include 'connection.php';

if ($_SERVER["REQUEST_METHOD"] == "POST") {

    $email = trim($_POST['email']);
    $password = $_POST['password'];

    // FUNCTIONS TO CHECK EACH TABLE
    function checkLogin($conn, $table, $role, $email, $password) {

    $sql = "SELECT id, name, email, password FROM $table WHERE email = ?";
    $stmt = $conn->prepare($sql);

    if (!$stmt) {
        die("SQL Error: " . $conn->error);
    }

    $stmt->bind_param("s", $email);
    $stmt->execute();

    // Store result
    $result = $stmt->get_result();

    // If no matching email, return false
    if ($result->num_rows === 0) {
        return false;
    }

    // Fetch row as array
    $row = $result->fetch_assoc();

    $id = $row['id'];
    $name = $row['name'];
    $email_db = $row['email'];
    $hashed_password = $row['password'];

    // Now verify password
    if (password_verify($password, $hashed_password)) {

        // store session
        $_SESSION['user_id'] = $id;
        $_SESSION['name'] = $name;
        $_SESSION['email'] = $email_db;
        $_SESSION['role'] = $role;

        // Redirect based on role
        if ($role === "admin") {
            header("Location: admin_dashboard.php");
        } elseif ($role === "provider") {
            header("Location: provider_dashboard.php");
        } else {
            header("Location: customer_dashboard.php");
        }
        exit;
    }

    return false;
}


    // Try admin table
    if (checkLogin($conn, "tbladmin", "admin", $email, $password)) exit;

    // Try provider table
    if (checkLogin($conn, "tblproviders", "provider", $email, $password)) exit;

    // Try customer table
    if (checkLogin($conn, "tblcustomers", "customer", $email, $password)) exit;

    // If no match:
    echo "Invalid email or password!";
}
?>
