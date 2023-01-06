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
    public class SubCategoriesController : ControllerBase
    {
        private readonly ApplicationDBContext _context;
        private readonly IHttpContextAccessor httpContextAccessor;

        public SubCategoriesController(ApplicationDBContext context, IHttpContextAccessor httpContextAccessor)
        {
            _context = context;
            this.httpContextAccessor = httpContextAccessor;
        }

        // GET: api/SubCategories
        [HttpGet]
        public async Task<ActionResult> GetSubCategories()
        {
            string host = httpContextAccessor.HttpContext!.Request.Host.Value;
            string schema = httpContextAccessor.HttpContext.Request.Scheme;
            return Ok(await _context.SubCategories.Select(a=> new { a.ID, a.ArabicName, a.EnglishName ,
                ImageUrl = schema + "://" + host + "/api/Image/" + a.ImageUrl }).ToListAsync());
        }

        [HttpGet("top")]
        public async Task<ActionResult> GetSubCategoriesTop()
        {
            string host = httpContextAccessor.HttpContext!.Request.Host.Value;
            string schema = httpContextAccessor.HttpContext.Request.Scheme;
            return Ok(await _context.SubCategories.OrderByDescending(a=> a.ID).Skip(0).Take(10).Select(a => new {
                a.ID,
                a.ArabicName,
                a.EnglishName,
                ImageUrl = schema + "://" + host + "/api/Image/" + a.ImageUrl
            }).ToListAsync());
        }

        // GET: api/SubCategories/5
        [HttpGet("{id}")]
        public async Task<ActionResult<SubCategory>> GetSubCategory(int id)
        {
            var subCategory = await _context.SubCategories.FindAsync(id);

            if (subCategory == null)
            {
                return NotFound();
            }

            return subCategory;
        }

        // PUT: api/SubCategories/5
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPut("{id}")]
        public async Task<IActionResult> PutSubCategory(int id, SubCategory subCategory)
        {
            if (id != subCategory.ID)
            {
                return BadRequest();
            }

            _context.Entry(subCategory).State = EntityState.Modified;

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!SubCategoryExists(id))
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

        // POST: api/SubCategories
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPost]
        public async Task<ActionResult<SubCategory>> PostSubCategory(SubCategory subCategory)
        {
            _context.SubCategories.Add(subCategory);
            await _context.SaveChangesAsync();

            return CreatedAtAction("GetSubCategory", new { id = subCategory.ID }, subCategory);
        }

        // DELETE: api/SubCategories/5
        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteSubCategory(int id)
        {
            var subCategory = await _context.SubCategories.FindAsync(id);
            if (subCategory == null)
            {
                return NotFound();
            }

            _context.SubCategories.Remove(subCategory);
            await _context.SaveChangesAsync();

            return NoContent();
        }

        private bool SubCategoryExists(int id)
        {
            return _context.SubCategories.Any(e => e.ID == id);
        }
    }
}
