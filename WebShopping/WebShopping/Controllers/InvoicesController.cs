using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using WebShopping.Models;
using WebShopping.UnitOfWork;

namespace WebShopping.Controllers
{
    public class InvoicesController : Controller
    {
        private readonly IUnitOfWork unitOfWork;
        private readonly ApplicationDBContext context;

        public InvoicesController(IUnitOfWork unitOfWork , ApplicationDBContext context)
        {
            this.unitOfWork = unitOfWork;
            this.context = context;
        }
        public IActionResult Index()
        {
            return View();
        }

        public async Task<IActionResult> GetInvoices(int start = 0, int length = 10)
        {
            var search = Request.Query["search[value]"].ToString();
            var query = await this.unitOfWork.Invoice.GetDataTable(start, length, a => a.InvoiceNumber.ToString().Contains(search) ||
            a.User.PhoneNumber.Contains(search) || a.User.PharmacyName.Contains(search),a=> a.InvoiceNumber, a =>
            new {
                a.ID,
                a.InvoiceNumber,
                a.InvoiceDate,
                a.CurrencyCode,
                a.User.PhoneNumber,
                a.TotalInvoice,
                a.IsApproved
                

            });

            return Ok(query);
        }

        public async Task<IActionResult> Details(int? ID)
        {
            if(ID == null)
            {
                return NotFound();
            }
          var Invoice = await  this.unitOfWork.Invoice.GetByID(ID.Value);


            return View(Invoice);

        }
        [HttpPost]
        public async Task<IActionResult> ApproveInvoice([FromBody]int? id)
        {
            if(id == null)
            {
                return BadRequest();
            }
            var invoice = await context.Invoices.FirstOrDefaultAsync(a => a.ID == id);
            if(invoice == null)
            {
                return NotFound();
            }
            invoice.IsApproved = true;
            context.SaveChanges();
            return Ok(invoice);

           
        }
       

       
    }
}
