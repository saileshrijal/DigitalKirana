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
    $query = "select s.SupplierName, s.Email, s.Phone, s.Address, p.Vat, p.Discount, p.BillNumber, p.GrossTotal, p.NetTotal, p.Remarks, p.CreatedAt, t.LogoUrl, t.Name, t.Email, t.Phone, t.Address from purchase p inner join supplier s on p.SupplierId = s.Id inner join Tenants t on p.TenantId = t.Id where p.Id = :purchaseId";
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
    <div class="row">
        <div class="col-6">
            <a href="/purchase" class="btn btn-primary"><i class="fas fa-fw fa-arrow-left"></i> View Purchase</a>
        </div>
        <div class="col-6">
            <button type="button" class="btn btn-secondary float-right" id="printBtn"><i class="fas fa-fw fa-print"></i> Print</button>
        </div>
    </div>
    <div class="card mt-2">
        <div class="card-header bg-primary text-white ">
            <h4 class="card-title">Purchase Details</h4>
        </div>
        <div class="card-body bg-white" id="printableArea">
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

<!-- template for printing -->
<template id="printTemplate">
    <div class="border mb-3 p-3">
        <div class="row d-flex align-items-center">
            <div class="col-12 mb-4">
                <div class="text-center mb-3">
                    <?php
                    if ($purchase['LogoUrl'] != '') :
                    ?>
                        <img src="/assets/imgs/logos/<?= $purchase['LogoUrl'] ?>" alt="" width="70" class="rounded-circle border border-4">
                    <?php
                    endif;
                    ?>
                </div>
                <h2 class="text-primary text-center mb-3"><?= $purchase['Name'] ?></h2>
                <div class="row">
                    <div class="col-4">
                        <p class="my-0 text-center"><span style="font-weight: 800;">Phone:</span> <?= $purchase['Phone'] ?></p>
                    </div>
                    <div class="col-4">
                        <p class="my-0 text-center"><span style="font-weight: 800;">Address:</span> <?= $purchase['Address'] ?></p>
                    </div>
                    <div class="col-4">
                        <p class="my-0 text-center"><span style="font-weight: 800;">Email:</span> <?= $purchase['Email'] ?></p>
                    </div>

                </div>
            </div>
        </div>
    </div>
</template>

<script>
    //print printable area on click
    const printBtn = document.getElementById('printBtn');
    printBtn.addEventListener('click', () => {
        printSection();
    });

    function printSection() {

        //add template to printable area
        const printTemplate = document.querySelector('#printTemplate');
        const printableArea = document.querySelector('#printableArea');
        const printClone = printTemplate.content.cloneNode(true);
        printableArea.prepend(printClone);

        //print printable area
        const printContents = printableArea.innerHTML;

        const originalContents = document.body.innerHTML;

        document.body.innerHTML = printContents;
        window.print();

        document.body.innerHTML = originalContents;
        //remove clone from printable area
    }
</script>

<?php
require_once '../includes/themeFooter.php';
?>