<?php
require_once '../includes/functions.php';
require_once '../includes/Connection.php';
require_once '../constants/Role.php';
require_once '../includes/authorize_user.php';


$tenantId = getTenantId(); //getting tenant id from session

// check if form is submitted
if (isPost()) {
    // get form data
    $categoryName = $_POST['categoryName'];
    $description = $_POST['description'];

    // create category
    $connection = ConnectionHelper::getConnection();
    $query = "INSERT INTO category (CategoryName, Description, TenantId, CreatedAt, UserId) VALUES (:categoryName, :description, :tenantId, :createdAt, :userId)";
    $statement = $connection->prepare($query);
    $statement->bindParam(':categoryName', $categoryName);
    $statement->bindParam(':description', $description);
    $statement->bindParam(':tenantId', $tenantId);
    $createdDate = date('Y-m-d H:i:s');
    $statement->bindParam(':createdAt', $createdDate);
    $userId = getLoggedInUserId();
    $statement->bindParam(':userId', $userId);
    $statement->execute();
    $result = $statement->rowCount();
    if ($result > 0) {
        AddSuccessMessage("Category created successfully");
        header("Location: /category");
    } else {
        AddErrorMessage("Failed to create category");
    }
}

require_once '../includes/themeHeader.php';
?>

<div class="container-fluid">
    <form action="" method="post">

        <a href="/category" class="btn btn-danger"><i class="fas fa-fw fa-arrow-left"></i> Back to Categories</a>
        <div class="card mt-2  shadow-lg">
            <div class="card-header bg-primary">
                <h4 class="card-title text-light">Create Category</h4>
            </div>
            <div class="card-body bg-gray">
                <?php renderMessages(); ?>
                <div class="row">
                    <div class="col-12 mb-4">
                        <label for="categoryName">Category Name</label>
                        <input type="text" name="categoryName" id="categoryName" class="form-control" placeholder="Category Name" required>
                    </div>
                    <div class="col-12 mb-4">
                        <label for="description">Description</label>
                        <textarea type="text" name="description" id="description" class="form-control" placeholder="Description" rows="8"></textarea>
                    </div>
                </div>
            </div>
            <div class="card-footer">
                <button type="submit" class="btn btn-primary"><i class="fas fa-fw fa-save"></i> Save</button>
            </div>
        </div>
    </form>
</div>

<?php
require_once '../includes/themeFooter.php';
?>