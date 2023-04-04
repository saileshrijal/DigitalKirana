<?php
require_once '../includes/functions.php';
require_once '../includes/Connection.php';

// check authentication
if (!checkAuth()) {
    header("Location: /?returnUrl=" . $_SERVER['REQUEST_URI']);
}

// get purchase id
$purchaseId = getParam('id');

//get all purchased products by purchaseId
function getAllPurchasedProducts($purchaseId)
{
    $connection = ConnectionHelper::getConnection();
    $query = "select p.ProductCode, p.ProductName, pd.Quantity, pd.Rate, pd.TotalAmount from purchase_details pd inner join product p on pd.ProductId = p.Id where pd.PurchaseId = :purchaseId";
    $statement = $connection->prepare($query);
    $statement->bindParam('purchaseId', $purchaseId, PDO::PARAM_INT);
    $statement->execute();
    $result = $statement->fetchAll(PDO::FETCH_ASSOC);
    return $result;
}

//get purchase by purchaseId
function getPurchase($purchaseId)
{
    $connection = ConnectionHelper::getConnection();
    $query = "select s.SupplierName, s.Email, s.Phone, s.Address, p.Vat, p.Discount, p.BillNumber, p.GrossTotal, p.NetTotal, p.Remarks, p.CreatedAt from purchase p inner join supplier s on p.SupplierId = s.Id where p.Id = :purchaseId";
    $statement = $connection->prepare($query);
    $statement->bindParam('purchaseId', $purchaseId, PDO::PARAM_INT);
    $statement->execute();
    $result = $statement->fetch(PDO::FETCH_ASSOC);
    return $result;
}


// get all purchased products
$purchasedProducts = getAllPurchasedProducts($purchaseId);
// get purchase
$purchase = getPurchase($purchaseId);

require_once '../includes/themeHeader.php';
?>
<div class="container-fluid ">
    <a href="/purchase" class="btn btn-primary"><i class="fas fa-fw fa-arrow-left"></i> View Purchase</a>
    <div class="card mt-2">
        <div class="card-header bg-primary text-white ">
            <h4 class="card-title">Purchase Details</h4>
        </div>
        <div class="card-body">
            <div class="card shadow-lg">
                <div class="card-header">
                    <h6 class="card-title text-primary">Products</h6>
                </div>
                <div class="card-body">
                    <div class="table-responsive">
                        <table class="table table-bordered">
                            <thead>
                                <tr>
                                    <th scope="col">#</th>
                                    <th scope="col">Product Code</th>
                                    <th scope="col">Product Name</th>
                                    <th scope="col">Rate</th>
                                    <th scope="col">Quantity</th>
                                    <th scope="col">Total Price</th>
                                </tr>
                            </thead>
                            <tbody>
                                <?php
                                $sn = 0;
                                foreach ($purchasedProducts as $purchasedProduct) :
                                ?>
                                    <tr>
                                        <td scope="row">
                                            <?= ++$sn ?>
                                        </td>
                                        <td>
                                            <?= $purchasedProduct['ProductCode'] ?>
                                        </td>
                                        <td>
                                            <?= $purchasedProduct['ProductName'] ?>
                                        </td>
                                        <td>
                                            <?= $purchasedProduct['Rate'] ?>
                                        </td>
                                        <td>
                                            <?= $purchasedProduct['Quantity'] ?>
                                        </td>
                                        <td>
                                            <?= $purchasedProduct['TotalAmount'] ?>
                                        </td>
                                    </tr>
                                <?php endforeach; ?>
                                <!-- add total row below -->
                                <tr>
                                    <td colspan="5" class="text-right">Total</td>
                                    <td><?= $purchase['GrossTotal'] ?></td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-md-6">
                    <div class="card my-4 shadow-lg">
                        <div class="card-header">
                            <h6 class="card-title text-primary">Transaction Details</h6>
                        </div>
                        <div class="card-body">
                            <table class="table table-bordered">
                                <tbody>
                                    <tr>
                                        <th scope="row">Date</th>
                                        <td><?= $purchase['CreatedAt'] ?></td>
                                    </tr>
                                    <tr>
                                        <th scope="row">Bill Number</th>
                                        <td><?= $purchase['BillNumber'] ?></td>
                                    </tr>
                                    <tr>
                                        <th scope="row">Gross Total</th>
                                        <td><?= $purchase['GrossTotal'] ?></td>
                                    </tr>
                                    <tr>
                                        <th scope="row">Discount(%)</th>
                                        <td><?= $purchase['Discount'] ?></td>
                                    </tr>
                                    <tr>
                                        <th scope="row">Vat(%)</th>
                                        <td><?= $purchase['Vat'] ?></td>
                                    </tr>
                                    <tr>
                                        <th scope="row">Net Total</th>
                                        <td><?= $purchase['NetTotal'] ?></td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="card mt-4">
                        <div class="card shadow-lg">
                            <div class="card-header">
                                <h6 class="card-title text-primary">Supplier Info</h6>
                            </div>
                            <div class="card-body">
                                <table class="table table-bordered">
                                    <tbody>
                                        <tr>
                                            <th scope="row">Name</th>
                                            <td><?= $purchase['SupplierName'] ?></td>
                                        </tr>
                                        <tr>
                                            <th scope="row">Email</th>
                                            <td><?= $purchase['Email'] ?></td>
                                        </tr>
                                        <tr>
                                            <th scope="row">Phone</th>
                                            <td><?= $purchase['Phone'] ?></td>
                                        </tr>
                                        <tr>
                                            <th scope="row">Address</th>
                                            <td><?= $purchase['Address'] ?></td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>


        </div>

    </div>
</div>

<?php
require_once '../includes/themeFooter.php';
?>