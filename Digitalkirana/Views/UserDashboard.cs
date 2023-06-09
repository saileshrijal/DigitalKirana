﻿using Digitalkirana.DataAccessLayer;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace Digitalkirana.Views
{
    public partial class UserDashboard : Form
    {
        public UserDashboard()
        {
            InitializeComponent();
        }

        PurchaseDAL purchaseDAL = new PurchaseDAL();
        SalesDAL salesDAL = new SalesDAL();
        UserDAL userDAL = new UserDAL();
        SupplierDAL supplierDAL = new SupplierDAL();
        CustomerDAL customerDAL = new CustomerDAL();

        private void UserDashboard_Load(object sender, EventArgs e)
        {
            labelUsername.Text = Login.fullName;
            loadDisplayData();
        }

        private void loadDisplayData()
        {
            int userId = userDAL.getUserId(Login.username);
            var totalPurchase = purchaseDAL.GetTotalPurchaseByUsername(userId);
            var totalSales = salesDAL.GetTotalSalesByUsername(userId);
            var noOfSuppliers = supplierDAL.NoOfSuppliers();
            var noOfCustomers = customerDAL.NoOfCustomers();
            grossPurchaseLbl.Text = totalPurchase.ToString();
            grossSalesLbl.Text = totalSales.ToString();
            SuppliersLbl.Text = noOfSuppliers.ToString();
            CustomersLbl.Text = noOfCustomers.ToString();
        }

        private void inventoryToolStripMenuItem_Click(object sender, EventArgs e)
        {
            Purchase purchase = new Purchase();
            purchase.ShowDialog();
            loadDisplayData();
        }

        private void usersToolStripMenuItem_Click(object sender, EventArgs e)
        {
            Sales sales = new Sales();
            sales.ShowDialog();
            loadDisplayData();
        }

        private void suppliersToolStripMenuItem_Click(object sender, EventArgs e)
        {
            Supplier supplier = new Supplier();
            supplier.ShowDialog();
            loadDisplayData();
        }

        private void customersToolStripMenuItem_Click(object sender, EventArgs e)
        {
            Customer customer = new Customer();
            customer.ShowDialog();
            loadDisplayData();
        }

        private void transactionsToolStripMenuItem_Click(object sender, EventArgs e)
        {
            Inventory inventory = new Inventory();
            inventory.ShowDialog();
            loadDisplayData();
        }
    }
}
