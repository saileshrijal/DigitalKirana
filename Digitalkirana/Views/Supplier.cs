﻿using Digitalkirana.BusinessLogicLayer;
using Digitalkirana.DataAccessLayer;
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
    public partial class Supplier : Form
    {
        public Supplier()
        {
            InitializeComponent();
        }

        SupplierBLL supplier = new SupplierBLL();
        SupplierDAL supplierDAL = new SupplierDAL();
        UserDAL userDAL = new UserDAL();

        private void Supplier_Load(object sender, EventArgs e)
        {
            dataGridViewSupplier.DataSource = supplierDAL.SelectAllSuppliers();
        }

        private void btnSave_Click(object sender, EventArgs e)
        {
            if (textBoxSupplierName.Text != "" && textBoxEmail.Text != "" && textBoxPhone.Text != "" && textBoxAddress.Text != "")
            {
                supplier.SupplierName = textBoxSupplierName.Text;
                supplier.Email = textBoxEmail.Text;
                supplier.Phone = textBoxPhone.Text;
                supplier.Address = textBoxAddress.Text;
                supplier.AddedDate = DateTime.Now;
                supplier.AddedBy = userDAL.getUserId(Login.username);

                if (supplier.Id > 0)
                {
                    supplierDAL.UpdateSupplier(supplier);
                }
                else
                {
                    supplierDAL.InsertSupplier(supplier);
                }
                dataGridViewSupplier.DataSource = supplierDAL.SelectAllSuppliers();
                reset();
            }
            else
            {
                MessageBox.Show("Some field is missing!!", "Missing", MessageBoxButtons.OK, MessageBoxIcon.Asterisk);
            }
        }

        private void reset()
        {
            textBoxSupplierName.Clear();
            textBoxEmail.Clear();
            textBoxAddress.Clear();
            textBoxPhone.Clear();
            supplier.Id = 0;
            btnSave.Text = "Add";
            btnDelete.Enabled = false;
        }

        private void btnDelete_Click(object sender, EventArgs e)
        {
            var result = MessageBox.Show("Do you really want to delete?", "Delete", MessageBoxButtons.OKCancel, MessageBoxIcon.Question);
            if (result == DialogResult.Cancel)
            {
                return;
            }
            var checkStatus = supplierDAL.CheckSupplierInPurchase(supplier.Id);
            if (!checkStatus)
            {
                supplierDAL.DeleteSupplier(supplier);
                dataGridViewSupplier.DataSource = supplierDAL.SelectAllSuppliers();
                reset();
            }
            else
            {
                MessageBox.Show("This supplier could not be deleted because it has been used in a purchase", "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
            }
        }

        private void textBoxSearch_TextChanged(object sender, EventArgs e)
        {
            string keyword = textBoxSearch.Text;
            if (keyword == null)
            {
                dataGridViewSupplier.DataSource = supplierDAL.SelectAllSuppliers();
            }
            else
            {
                dataGridViewSupplier.DataSource = supplierDAL.SearchSupplier(keyword);
            }
        }

        private void dataGridViewSupplier_CellClick(object sender, DataGridViewCellEventArgs e)
        {
            int rowIndex = e.RowIndex;
            if (rowIndex < 0)
            {
                return;
            }
            DataGridViewRow selectedRow = dataGridViewSupplier.Rows[rowIndex];
            supplier.Id = Convert.ToInt32(selectedRow.Cells[0].Value);
            textBoxSupplierName.Text = selectedRow.Cells[1].Value.ToString();
            textBoxEmail.Text = selectedRow.Cells[2].Value.ToString();
            textBoxPhone.Text = selectedRow.Cells[3].Value.ToString();
            textBoxAddress.Text = selectedRow.Cells[4].Value.ToString();
            btnSave.Text = "Update";
            btnDelete.Enabled = true;
        }

        private void btnReset_Click(object sender, EventArgs e)
        {
            var result = MessageBox.Show("Do you really want to reset?", "Reset", MessageBoxButtons.OKCancel, MessageBoxIcon.Question);
            if (result == DialogResult.Cancel)
            {
                return;
            }
            reset();
        }
    }
}
