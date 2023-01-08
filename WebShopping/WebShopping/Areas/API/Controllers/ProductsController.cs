using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using WebShopping.Helpers;
using WebShopping.Models;
using WebShopping.Repository.interfaces;
using WebShopping.UnitOfWork;

namespace WebShopping.Areas.API.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    [Authorize(AuthenticationSchemes = JwtBearerDefaults.AuthenticationScheme)]
    public class ProductsController : ControllerBase
    {
        private readonly ApplicationDBContext _context;
        private readonly IUnitOfWork unit;
        private readonly IHttpContextAccessor httpContextAccessor;

        public ProductsController(ApplicationDBContext context, IUnitOfWork unit, IHttpContextAccessor httpContextAccessor)
        {
            _context = context;
            this.unit = unit;
            this.httpContextAccessor = httpContextAccessor;
        }

        // GET: api/Products
        [HttpGet]
        public async Task<ActionResult<IEnumerable<DataTableViewModel<Product>>>> GetProducts(int start = 0, int length = 10, string? search = "")
        {
            var testing = User.GetUserId();
            string host = httpContextAccessor.HttpContext!.Request.Host.Value;
            string schema = httpContextAccessor.HttpContext.Request.Scheme;
            if (search == null)
            {
                search = "";
            }

            var query = await this.unit.Products.GetDataTable(start, length, a => a.ArabicName.Contains(search) || a.EnglishName.Contains(search), a => a.ID, a => new {
                a.ArabicName,
                a.DescriptionArabic,
                a.DescriptionEnglish,
                a.EnglishName,
                a.ID,
                ImageUrl = schema + "://" + host + "/api/Image/" + a.ImageUrl,
                a.PurchasingPriceForPublic,
                a.PurchasingPriceForSales,
                a.Quantity,
                a.SellingPrice,
                a.SubCategoryID,
               UserQuantity =  a.Carts.FirstOrDefault(a=> a.UserID == testing) == null ?0 : a.Carts.FirstOrDefault(a => a.UserID == testing)!.Quantity
            });
            return Ok(query);
        }


        [HttpGet("brand/{id?}")]
        public async Task<ActionResult<IEnumerable<DataTableViewModel<Product>>>> GetProductsBrands(int? id, int start = 0, int length = 10, string? search = "")
        {
            if (id == null)
            {
                return BadRequest("Please Specifie the brand");
            }
            var testing = User.GetUserId();
            string host = httpContextAccessor.HttpContext!.Request.Host.Value;
            string schema = httpContextAccessor.HttpContext.Request.Scheme;
            if (search == null)
            {
                search = "";
            }

            var query = await this.unit.Products.GetDataTable(start, length, a => a.BrandID == id && (a.ArabicName.Contains(search) || a.EnglishName.Contains(search)), a => a.ID, a => new {
                a.ArabicName,
                a.DescriptionArabic,
                a.DescriptionEnglish,
                a.EnglishName,
                a.ID,
                ImageUrl = schema + "://" + host + "/api/Image/" + a.ImageUrl,
                a.PurchasingPriceForPublic,
                a.PurchasingPriceForSales,
                a.Quantity,
                a.SellingPrice,
                a.SubCategoryID,
                UserQuantity = a.Carts.FirstOrDefault(a => a.UserID == testing) == null ? 0 : a.Carts.FirstOrDefault(a => a.UserID == testing)!.Quantity


            });
            return Ok(query);
        }

        [HttpGet("subCategory/{id?}")]
        public async Task<ActionResult<IEnumerable<DataTableViewModel<Product>>>> GetProductsSubCategoryCategory(int? id, int start = 0, int length = 10, string? search = "")
        {
            if (id == null)
            {
                return BadRequest("Please Specifie the brand");
            }
            var testing = User.GetUserId();
            string host = httpContextAccessor.HttpContext!.Request.Host.Value;
            string schema = httpContextAccessor.HttpContext.Request.Scheme;
            if (search == null)
            {
                search = "";
            }

            var query = await this.unit.Products.GetDataTable(start, length, a => a.SubCategoryID == id && (a.ArabicName.Contains(search) || a.EnglishName.Contains(search)), a => a.ID, a => new {
                a.ArabicName,
                a.DescriptionArabic,
                a.DescriptionEnglish,
                a.EnglishName,
                a.ID,
                ImageUrl = schema + "://" + host + "/api/Image/" + a.ImageUrl,
                a.PurchasingPriceForPublic,
                a.PurchasingPriceForSales,
                a.Quantity,
                a.SellingPrice,
                a.SubCategoryID,
                UserQuantity = a.Carts.FirstOrDefault(a => a.UserID == testing) == null ? 0 : a.Carts.FirstOrDefault(a => a.UserID == testing)!.Quantity
            });
            return Ok(query);
        }


        [HttpGet("Category/{id?}")]
        public async Task<ActionResult<IEnumerable<DataTableViewModel<Product>>>> GetProductsCategoryCategory(int? id, int start = 0, int length = 10, string? search = "")
        {
            if (id == null)
            {
                return BadRequest("Please Specifie the brand");
            }
            var testing = User.GetUserId();
            string host = httpContextAccessor.HttpContext!.Request.Host.Value;
            string schema = httpContextAccessor.HttpContext.Request.Scheme;
            if (search == null)
            {
                search = "";
            }

            var query = await this.unit.Products.GetDataTable(start, length, a => a.SubCategory.CategoryID == id && (a.ArabicName.Contains(search) || a.EnglishName.Contains(search)), a => a.ID, a => new {
                a.ArabicName,
                a.DescriptionArabic,
                a.DescriptionEnglish,
                a.EnglishName,
                a.ID,
                ImageUrl = schema + "://" + host + "/api/Image/" + a.ImageUrl,
                a.PurchasingPriceForPublic,
                a.PurchasingPriceForSales,
                a.Quantity,
                a.SellingPrice,
                a.SubCategoryID,
                UserQuantity = a.Carts.FirstOrDefault(a => a.UserID == testing) == null ? 0 : a.Carts.FirstOrDefault(a => a.UserID == testing)!.Quantity
            });
            return Ok(query);
        }


        // GET: api/Products/5
        [HttpGet("{id}")]
        public async Task<ActionResult<Product>> GetProduct(int id)
        {
            var product = await _context.Products.FindAsync(id);

            if (product == null)
            {
                return NotFound();
            }

            return product;
        }

        // PUT: api/Products/5
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPut("{id}")]
        public async Task<IActionResult> PutProduct(int id, Product product)
        {
            if (id != product.ID)
            {
                return BadRequest();
            }

            _context.Entry(product).State = EntityState.Modified;

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!ProductExists(id))
                {
                    return NotFound();
                }
                else
                {
                    throw;
                }
            }

            return NoContent();
        }

        // POST: api/Products
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPost]
        public async Task<ActionResult<Product>> PostProduct(Product product)
        {
            _context.Products.Add(product);
            await _context.SaveChangesAsync();

            return CreatedAtAction("GetProduct", new { id = product.ID }, product);
        }

        // DELETE: api/Products/5
        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteProduct(int id)
        {
            var product = await _context.Products.FindAsync(id);
            if (product == null)
            {
                return NotFound();
            }

            _context.Products.Remove(product);
            await _context.SaveChangesAsync();

            return NoContent();
        }

        private bool ProductExists(int id)
        {
            return _context.Products.Any(e => e.ID == id);
        }
    }
}
