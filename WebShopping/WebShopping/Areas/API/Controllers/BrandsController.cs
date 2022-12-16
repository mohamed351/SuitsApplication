using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using WebShopping.Models;

namespace WebShopping.Areas.API.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class BrandsController : ControllerBase
    {
        private readonly ApplicationDBContext _context;
        private readonly IHttpContextAccessor httpContextAccessor;

        public BrandsController(ApplicationDBContext context, IHttpContextAccessor httpContextAccessor)
        {
            _context = context;
            this.httpContextAccessor = httpContextAccessor;
        }

        // GET: api/Brands
        [HttpGet]
        public async Task<ActionResult> GetBrands()
        {
            string host = httpContextAccessor.HttpContext!.Request.Host.Value;
            string schema = httpContextAccessor.HttpContext.Request.Scheme;
            return Ok(await _context.Brands.Select(a=> new { 
                a.BrandArabic,
                a.BrandEnglish,
               ImageUrl = schema + "://" + host + "/api/Image/" + a.ImageUrl
            }).ToListAsync());
        }

        [HttpGet("top")]
        public async Task<ActionResult> GetBrandsTop10()
        {
            string host = httpContextAccessor.HttpContext!.Request.Host.Value;
            string schema = httpContextAccessor.HttpContext.Request.Scheme;
            return Ok(await _context.Brands.OrderByDescending(a=> a.ID).Skip(0).Take(10).Select(a => new {
                a.BrandArabic,
                a.BrandEnglish,
                ImageUrl = schema + "://" + host + "/api/Image/" + a.ImageUrl
            }).ToListAsync());
        }




        // GET: api/Brands/5
        [HttpGet("{id}")]
        public async Task<ActionResult<Brand>> GetBrand(int id)
        {
            var brand = await _context.Brands.FindAsync(id);

            if (brand == null)
            {
                return NotFound();
            }

            return brand;
        }

        // PUT: api/Brands/5
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPut("{id}")]
        public async Task<IActionResult> PutBrand(int id, Brand brand)
        {
            if (id != brand.ID)
            {
                return BadRequest();
            }

            _context.Entry(brand).State = EntityState.Modified;

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!BrandExists(id))
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

        // POST: api/Brands
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPost]
        public async Task<ActionResult<Brand>> PostBrand(Brand brand)
        {
            _context.Brands.Add(brand);
            await _context.SaveChangesAsync();

            return CreatedAtAction("GetBrand", new { id = brand.ID }, brand);
        }

        // DELETE: api/Brands/5
        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteBrand(int id)
        {
            var brand = await _context.Brands.FindAsync(id);
            if (brand == null)
            {
                return NotFound();
            }

            _context.Brands.Remove(brand);
            await _context.SaveChangesAsync();

            return NoContent();
        }

        private bool BrandExists(int id)
        {
            return _context.Brands.Any(e => e.ID == id);
        }
    }
}
