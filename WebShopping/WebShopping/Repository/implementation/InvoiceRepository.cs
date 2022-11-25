using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using System.Linq.Expressions;
using WebShopping.Models;
using WebShopping.Repository.interfaces;
using static Microsoft.EntityFrameworkCore.DbLoggerCategory;

namespace WebShopping.Repository.implementation
{
    public class InvoiceRepository : Repository<Invoice, int>, IInvoiceRepository
    {
        private readonly ApplicationDBContext context;

        public InvoiceRepository(ApplicationDBContext context)
            : base(context)
        {
            this.context = context;
        }


        public override Task<DataTableViewModel<TResult>> GetDataTable<TResult>(int start, int lenght, Expression<Func<Invoice, bool>> search, Expression<Func<Invoice, int>> OrderBy, Expression<Func<Invoice, TResult>> select)
        {
             var query = context.Set<Invoice>().Include(a=> a.User)
                .Include(a=> a.InvoiceDetails)
                .OrderBy(OrderBy).Skip(start).Take(lenght).Where(search);


            var count = context.Set<Invoice>().Where(search).Count();

            return Task.FromResult( new DataTableViewModel<TResult>()
            {
                data = query.Select(select).ToList(),
                recordsFiltered = count,
                recordsTotal = count
            });
        }

        public override Task<Invoice?> GetByID(int key)
        {
            return this.context.Invoices.Include(a => a.User)
                .Include(a => a.InvoiceDetails)
                .ThenInclude(a => a.Product)
                .FirstOrDefaultAsync(a => a.ID == key);
        }

    }

   
}
