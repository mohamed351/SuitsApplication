using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using Microsoft.EntityFrameworkCore;
using WebShopping.Helpers;
using WebShopping.Models;
using WebShopping.UnitOfWork;

namespace WebShopping.Controllers
{
    [Authorize]
    public class ProductsController : Controller
    {
        private readonly ApplicationDBContext _context;
        private readonly IUnitOfWork unit;
        private readonly IWebHostEnvironment hostEnvironment;

        public ProductsController(ApplicationDBContext context,IUnitOfWork unit , IWebHostEnvironment hostEnvironment)
        {
            _context = context;
            this.unit = unit;
            this.hostEnvironment = hostEnvironment;
        }

        // GET: Products
        public IActionResult  Index()
        {
        
            return View();
        }
    
        public async Task<IActionResult> GetProducts(int start = 0 ,int length = 10)
        {
            var search = Request.Query["search[value]"].ToString();
            
            var query = await this.unit.Products.GetDataTable(start, length, (a => a.ArabicName.Contains(search) || a.EnglishName.Contains(search) && a.IsDeleted == false), a => a.ID);
            return Ok(query);
        }

        // GET: Products/Details/5
        public async Task<IActionResult> Details(int? id)
        {
            if (id == null || _context.Products == null)
            {
                return NotFound();
            }

            var product = await _context.Products
                .Include(p => p.SubCategory)
                .FirstOrDefaultAsync(m => m.ID == id);
            if (product == null)
            {
                return NotFound();
            }

            return View(product);
        }

        // GET: Products/Create
        public IActionResult Create()
        {
            
          
          
            ViewData["SubCategoryID"] = new SelectList(_context.SubCategories, "ID", "EnglishName");
            ViewBag.BrandID = new SelectList(_context.Brands, "ID", "BrandEnglish");
            return View();
        }

    
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Create([Bind("ID,EnglishName,ArabicName,SellingPrice,PurchasingPriceForPublic,PurchasingPriceForSales,Quantity,ImageUrl,DescriptionArabic,DescriptionEnglish,IsDeleted,SubCategoryID")] Product product)
        {
            product.IsDeleted = false;
            if (ModelState.IsValid)
            {
                product.ImageUrl = ImageHelpers.ConvertMainImage(product.ImageUrl!, hostEnvironment);
                _context.Add(product);
                await _context.SaveChangesAsync();
                return RedirectToAction(nameof(Index));
            }
            ViewData["SubCategoryID"] = new SelectList(_context.SubCategories, "ID", "EnglishName", product.SubCategoryID);
            return View(product);
        }

        // GET: Products/Edit/5
        public async Task<IActionResult> Edit(int? id)
        {
            if (id == null || _context.Products == null)
            {
                return NotFound();
            }

            var product = await _context.Products.FindAsync(id);
            if (product == null)
            {
                return NotFound();
            }


            ViewData["BrandID"] = new SelectList(_context.Brands, "ID", "BrandEnglish", product.BrandID);
            ViewData["SubCategoryID"] = new SelectList(_context.SubCategories, "ID", "EnglishName", product.SubCategoryID);
            return View(product);
        }

        // POST: Products/Edit/5
        // To protect from overposting attacks, enable the specific properties you want to bind to.
        // For more details, see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Edit(int id, [Bind("ID,EnglishName,ArabicName,SellingPrice,PurchasingPriceForPublic,PurchasingPriceForSales,Quantity,ImageUrl,DescriptionArabic,DescriptionEnglish,IsDeleted,SubCategoryID,BrandID")] Product product)
        {
            if (id != product.ID)
            {
                return NotFound();
            }

            if (ModelState.IsValid)
            {
                try
                {
                    if(product.ImageUrl != null)
                    {
                        product.ImageUrl = ImageHelpers.ConvertMainImage(product.ImageUrl, hostEnvironment);
                    }
                    else
                    {
                        var currentProduct = _context.Products.AsNoTracking().FirstOrDefault(a => a.ID == id);
               
                            product.ImageUrl = currentProduct.ImageUrl;
                        
                           
                    }
                    _context.Update(product);
                    await _context.SaveChangesAsync();
                }
                catch (DbUpdateConcurrencyException)
                {
                    if (!ProductExists(product.ID))
                    {
                        return NotFound();
                    }
                    else
                    {
                        throw;
                    }
                }
                return RedirectToAction(nameof(Index));
            }
            ViewBag.BrandID = new SelectList(_context.Brands.ToList(), "ID", "BrandEnglish");
            ViewData["SubCategoryID"] = new SelectList(_context.SubCategories, "ID", "ID", product.SubCategoryID);
            return View(product);
        }

        // GET: Products/Delete/5
        public async Task<IActionResult> Delete(int? id)
        {
            if (id == null || _context.Products == null)
            {
                return NotFound();
            }

            var product = await _context.Products
                .Include(p => p.SubCategory)
                .FirstOrDefaultAsync(m => m.ID == id);
            if (product == null)
            {
                return NotFound();
            }

            return View(product);
        }

        // POST: Products/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> DeleteConfirmed(int id)
        {
            if (_context.Products == null)
            {
                return Problem("Entity set 'ApplicationDBContext.Products'  is null.");
            }
            var product = await _context.Products.FindAsync(id);
            if (product != null)
            {
                _context.Products.Remove(product);
            }
            
            await _context.SaveChangesAsync();
            return RedirectToAction(nameof(Index));
        }

        private bool ProductExists(int id)
        {
          return _context.Products.Any(e => e.ID == id);
        }
    }
}
