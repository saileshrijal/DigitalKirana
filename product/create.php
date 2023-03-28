<?php
require_once '../includes/functions.php';
require_once '../includes/Connection.php';
require_once '../constants/Role.php';

// check authentication
if (!checkAuth()) {
    header("Location: /?returnUrl=" . $_SERVER['REQUEST_URI']);
}

$tenantId = getTenantId();

function getAllCategories()
{
    //get all users by tenant id
    $connection = ConnectionHelper::getConnection();
    $query = "select * from category where TenantId = :tenantId";
    $statement = $connection->prepare($query);
    $tenantId = getTenantId();
    $statement->bindParam('tenantId', $tenantId, PDO::PARAM_INT);
    $statement->execute();
    $result = $statement->fetchAll(PDO::FETCH_ASSOC);
    return $result;
}

// get all categories
$categories = getAllCategories();


//check duplicate product code by tenant id
function checkDuplicateProductCode($productCode)
{
    $connection = ConnectionHelper::getConnection();
    $query = "select * from product where ProductCode = :productCode and TenantId = :tenantId";
    $statement = $connection->prepare($query);
    $tenantId = getTenantId();
    $statement->bindParam('productCode', $productCode, PDO::PARAM_STR);
    $statement->bindParam('tenantId', $tenantId, PDO::PARAM_INT);
    $statement->execute();
    $result = $statement->fetchAll(PDO::FETCH_ASSOC);
    return $result;
}

// check if form is submitted
if (isPost()) {
    // get form data
    $productName = $_POST['productName'];
    $description = $_POST['description'];
    $productCode = $_POST['productCode'];
    $categoryId = $_POST['categoryId'];
    $costPrice = $_POST['costPrice'];
    $sellingPrice = $_POST['sellingPrice'];
    $wholesalePrice = $_POST['wholesalePrice'];
    $unit = $_POST['unit'];
    $quantity = $_POST['quantity'];

    // check duplicate product code
    $duplicateProductCode = checkDuplicateProductCode($productCode);

    if (count($duplicateProductCode) > 0) {
        AddErrorMessage("Product code already exists");
        header("Location: /product/create.php");
        exit();
    }

    // upload image
    //get logo from input
    $image = $_FILES['productImage'];

    $imageName = "";
    if ($image['size'] > 0) {
        $name = date('Y-m-d-H-i-s');
        $ext = ".png";
        $imageName = $name . $ext;
        saveProductImage($image['tmp_name'], $imageName);
    }


    // create user
    $connection = ConnectionHelper::getConnection();
    $query = "INSERT INTO product (ProductName, ProductCode,Description, TenantId, CreatedAt, UserId, CategoryId, CostPrice, SellingPrice, WholesalePrice, Unit, Quantity, ImageUrl) VALUES (:productName, :productCode, :description, :tenantId, :createdAt, :userId, :categoryId, :costPrice, :sellingPrice, :wholesalePrice, :unit, :quantity, :imageUrl)";
    $statement = $connection->prepare($query);
    $statement->bindParam(':productName', $productName);
    $statement->bindParam(':productCode', $productCode);
    $statement->bindParam(':description', $description);
    $statement->bindParam(':tenantId', $tenantId);
    $statement->bindParam(':categoryId', $categoryId);
    $statement->bindParam(':costPrice', $costPrice);
    $statement->bindParam(':sellingPrice', $sellingPrice);
    $statement->bindParam(':wholesalePrice', $wholesalePrice);
    $statement->bindParam(':unit', $unit);
    $statement->bindParam(':quantity', $quantity);
    $statement->bindParam(':imageUrl', $imageName);

    $createdDate = date('Y-m-d H:i:s');
    $statement->bindParam(':createdAt', $createdDate);
    $userId = getLoggedInUserId();
    $statement->bindParam(':userId', $userId);
    $statement->execute();
    $result = $statement->rowCount();
    if ($result > 0) {
        AddSuccessMessage("Product created successfully");
        header("Location: /Product");
    } else {
        AddErrorMessage("Failed to create product");
    }
}

require_once '../includes/themeHeader.php';
?>

<div class="container-fluid">
    <form action="" method="post" enctype="multipart/form-data">

        <a href="/product" class="btn btn-danger"><i class="fas fa-fw fa-arrow-left"></i> Back to Products</a>
        <div class="card mt-2  shadow-lg">
            <div class="card-header bg-primary">
                <h4 class="card-title text-light">Create Product</h4>
            </div>
            <div class="card-body bg-gray">
                <?php renderMessages(); ?>
                <div class="row">
                    <div class="col-9">
                        <div class="col-12 mb-4">
                            <label for="productName">Product Name</label>
                            <input type="text" name="productName" id="productName" class="form-control"
                                placeholder="Product Name" required>
                        </div>

                        <div class="col-12 mb-4">
                            <label for="productCode">Product Code</label>
                            <input type="text" name="productCode" id="productCode" class="form-control"
                                placeholder="Product Code" required>
                        </div>

                        <div class="col-12 mb-4">
                            <label for="description">Description</label>
                            <textarea type="text" name="description" id="description" class="form-control"
                                placeholder="Description" rows="6"></textarea>
                        </div>

                        <div class="col-12 mb-4">
                            <label for="categoryId">Category</label>
                            <select type="text" name="categoryId" id="category" class="form-control" required>
                                <option value="">Select Category</option>

                                <?php
                                foreach ($categories as $category):
                                    ?>
                                    <option value="<?= $category['Id'] ?>"><?= $category['CategoryName'] ?></option>
                                    <?php
                                endforeach;
                                ?>
                            </select>
                        </div>

                        <div class="col-12 mb-4">
                            <label for="unit">Unit</label>
                            <input type="text" name="unit" id="unit" class="form-control" placeholder="Unit" required>
                        </div>

                        <div class="col-12 mb-4">
                            <label for="sellingPrice">Selling Price</label>
                            <input type="number" name="sellingPrice" id="sellingPrice" class="form-control"
                                placeholder="Product Code" required>
                        </div>

                        <div class="col-12 mb-4">
                            <label for="costPrice">Cost Price</label>
                            <input type="number" name="costPrice" id="costPrice" class="form-control"
                                placeholder="Cost Price" required>
                        </div>

                        <div class="col-12 mb-4">
                            <label for="wholesalePrice">Wholesale Price</label>
                            <input type="number" name="wholesalePrice" id="wholesalePrice" class="form-control"
                                placeholder="Wholesale Price" required>
                        </div>

                        <div class="col-12 mb-4">
                            <label for="quantity">Quantity</label>
                            <input type="number" name="quantity" id="quantity" class="form-control"
                                placeholder="Quantity" required>
                        </div>

                        <div class="col-12 mb-4">
                            <label for="productImage">Upload Image</label>
                            <input type="file" name="productImage" id="productImage" class="form-control-file"
                                accept="image/*" onchange="showPreview(event);">
                        </div>
                    </div>
                    <div class="col-md-3">
                        <img src="/assets/imgs/products/default.png" class="img-fluid" id="imagePreview" />
                    </div>
                </div>
            </div>
            <div class="card-footer">
                <button type="submit" class="btn btn-primary"><i class="fas fa-fw fa-save"></i> Save</button>
            </div>
        </div>
    </form>
</div>

<script>
    function showPreview(event) {
        if (event.target.files.length > 0) {
            var src = URL.createObjectURL(event.target.files[0]);
            var preview = document.getElementById("imagePreview");
            preview.src = src;
        }
    }
</script>

<?php
require_once '../includes/themeFooter.php';
?>