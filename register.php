<?php
require_once 'includes/functions.php';
require_once 'includes/Connection.php';
require_once('constants/TenantStatus.php');

$connection = ConnectionHelper::getConnection();

function checkUsername($username)
{
    $connection = ConnectionHelper::getConnection();
    $checkUsername = "select * from user where Username = :username";
    $statement = $connection->prepare($checkUsername);
    $statement->bindParam('username', $username);
    $statement->execute();
    $result = $statement->rowCount();
    if ($result > 0) {
        return true;
    }
    return false;
}

if (isPost()) {
    $connection->beginTransaction();

    $firstName = $_POST['firstName'];
    $lastName = $_POST['lastName'];
    $email = $_POST['email'];
    $phone = $_POST['phone'];
    $address = $_POST['address'];
    $username = $_POST['username'];
    $password = $_POST['password'];
    $businessName = $_POST['businessName'];
    $businessEmail = $_POST['businessEmail'];
    $businessPhone = $_POST['businessPhone'];
    $businessAddress = $_POST['businessAddress'];

    $commandForTenant = "insert into tenants (Name, Email, Phone, Address, Status, CreatedAt) values (:businessName, :businessEmail, :businessPhone, :businessAddress, :businessStatus, :createdAt)";
    $statement = $connection->prepare($commandForTenant);
    $statement->bindParam('businessName', $businessName);
    $statement->bindParam('businessEmail', $businessEmail);
    $statement->bindParam('businessPhone', $businessPhone);
    $statement->bindParam('businessAddress', $businessAddress);
    $statement->bindParam('createdAt', date('Y-m-d H:i:s'));
    $statement->bindParam('businessStatus', TenantStatus::$Pending);
    $statement->execute();
    $tenantId = $connection->lastInsertId();
    if ($tenantId > 0) {
        if (checkUsername($username)) {
            addErrorMessage("Username already exists");
            header("Location: /register.php");
            return;
        }
        $commandForUser = "insert into user (FirstName, LastName, Email, Phone, Address, Username, PasswordHash, TenantId, CreatedAt, Role) values (:firstName, :lastName, :email, :phone, :address, :username, :passwordHash, :tenantId, :createdAt, :role)";
        $role = 'Admin';
        $statement = $connection->prepare($commandForUser);
        $statement->bindParam('firstName', $firstName);
        $statement->bindParam('lastName', $lastName);
        $statement->bindParam('email', $email);
        $statement->bindParam('phone', $phone);
        $statement->bindParam('address', $address);
        $statement->bindParam('username', $username);
        $passwordHash = password_hash($password, PASSWORD_DEFAULT);
        $statement->bindParam('passwordHash', $passwordHash);
        $statement->bindParam('tenantId', $tenantId);
        $statement->bindParam('createdAt', date('Y-m-d H:i:s'));
        $statement->bindParam('role', $role);
        $statement->execute();
        $result = $statement->rowCount();
        if ($result > 0) {
            $connection->commit();
            addSuccessMessage("Registration Successful! Login Now");
            header("Location: /");
        }
    }
}

require_once 'includes/header.php';
?>

<div class="container-fluid min-vh-100 d-flex align-items-center">
    <div class="container">
        <div class="row py-5">
            <div class="col-4">
                <div class="row">
                    <div class="col-12">
                        <h1 class="text-dark display-2 fw-bold">Register</h1>
                    </div>
                </div>
                <p class="text-dark py-4" style="text-align:justify">Lorem ipsum dolor sit amet consectetur, adipisicing
                    elit. Quaerat fugiat tempore commodi, nesciunt assumenda aspernatur deleniti molestias reiciendis
                    voluptas enim eos repudiandae est temporibus eum in ducimus sed facilis sapiente officia debitis, ?
                </p>
            </div>
            <div class="col-8">
                <div class="card bg-light shadow-lg">
                    <div class="card-body pt-5">
                        <?php renderMessages(); ?>
                        <form action="" method="post">
                            <div class="row">
                                <h5>Personal Details</h5>
                                <hr />
                                <div class="form-floating mb-3 col-6">
                                    <input type="text" id="firstName" name="firstName" class="form-control" placeholder="Enter First Name (*)" required>
                                    <label for="firstName">First Name (*)</label>
                                </div>

                                <div class="form-floating mb-3 col-6">
                                    <input type="text" id="lastName" name="lastName" class="form-control" placeholder="Enter First Name  (*)" required>
                                    <label for="lastName">Last Name (*)</label>
                                </div>

                                <div class="form-floating mb-3 col-6">
                                    <input type="email" id="email" name="email" class="form-control" placeholder="Enter Email (*)" required>
                                    <label for="email">Email (*)</label>
                                </div>

                                <div class="form-floating mb-3 col-6">
                                    <input type="tel" id="phone" name="phone" class="form-control" placeholder="Enter Phone (*)" required>
                                    <label for="phone">Phone (*)</label>
                                </div>

                                <div class="form-floating mb-3 col-12">
                                    <textarea id="address" name="address" class="form-control" placeholder="Enter Address (*)" required rows="8"></textarea>
                                    <label for="phone">Address (*)</label>
                                </div>

                                <div class="form-floating mb-3 col-12">
                                    <input type="text" id="username" name="username" class="form-control" placeholder="Enter Username (*)" required>
                                    <label for="username">Username (*)</label>
                                </div>

                                <div class="form-floating mb-3 col-12">
                                    <input type="password" id="password" name="password" class="form-control" placeholder="Enter Password (*)" required>
                                    <label for="password">Password (*)</label>
                                </div>

                                <h5>Business Details</h5>
                                <hr class="border-2 border-info" />

                                <div class="form-floating mb-3 col-6">
                                    <input type="text" id="businessName" name="businessName" class="form-control" placeholder="Enter Business Name (*)" required>
                                    <label for="businessName">Business Name (*)</label>
                                </div>

                                <div class="form-floating mb-3 col-6">
                                    <input type="email" id="businessEmail" name="businessEmail" class="form-control" placeholder="Enter Business Email (*)" required>
                                    <label for="businessEmail">Business Email (*)</label>
                                </div>

                                <div class="form-floating mb-3 col-12">
                                    <input type="tel" id="businessPhone" name="businessPhone" class="form-control" placeholder="Enter Business Phone (*)" required>
                                    <label for="businessPhone">Business Phone (*)</label>
                                </div>

                                <div class="form-floating mb-3 col-12">
                                    <textarea id="businessAddress" name="businessAddress" class="form-control" placeholder="Enter Business Address (*)" required rows="8"></textarea>
                                    <label for="businessAddress">Business Address (*)</label>
                                </div>

                                <div class="mb-3">
                                    <button type="submit" class="btn btn-outline-primary w-100">Register</button>
                                </div>
                                <div class="mb-3">
                                    <p class="text-center"><span>Already have an account? </span> <a href="/">Login</a>
                                    </p>
                                </div>
                            </div>

                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>


<?php
require_once 'includes/footer.php';
?>