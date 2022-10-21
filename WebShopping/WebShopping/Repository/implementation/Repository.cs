using LinqKit.Core;
using Microsoft.EntityFrameworkCore;
using System.Linq.Expressions;
using WebShopping.Models;
using WebShopping.Repository.interfaces;
using WebShopping.Specification.Interfaces;

namespace WebShopping.Repository.implementation
{
    public class Repository<TEntity, TKey> : IRepository<TEntity, TKey> where TEntity : class
    {
        private readonly ApplicationDBContext context;

        public Repository(ApplicationDBContext context)
        {
            this.context = context;
        }
        public void Add(TEntity entity)
        {
            context.Add(entity);
        }

        public void Delete(TEntity entity)
        {
            context.Remove(entity);
        }

        public async Task<IEnumerable<TEntity>> GetAllAsync()
        {
            return await context.Set<TEntity>().ToListAsync();
        }

        public async Task<TEntity> GetByID(TKey key)
        {
            return await context.Set<TEntity>().FindAsync(key);
        }

        public async Task<DataTableViewModel<TEntity>> GetDataTable(int start, int lenght, Expression<Func<TEntity, bool>> search, Expression<Func<TEntity, TKey>> OrderBy)
        {
            var query = context.Set<TEntity>().Where(search);


            var count = context.Set<TEntity>().Where(search).Count();

            return new DataTableViewModel<TEntity>()
            {
                data = query.Skip(start).Take(lenght).ToList(),
                recordsFiltered = count,
                recordsTotal = count
            };
        }


        public async Task<DataTableViewModel<TResult>> GetDataTable<TResult>(int start, int lenght, Expression<Func<TEntity, bool>> search, Expression<Func<TEntity, TKey>> OrderBy , Expression<Func<TEntity, TResult>> select) where TResult : class
        {
            var query = context.Set<TEntity>().OrderBy(OrderBy).Skip(start).Take(lenght).Where(search);


            var count = context.Set<TEntity>().Where(search).Count();

            return new DataTableViewModel<TResult>()
            {
                data = query.Select(select).ToList(),
                recordsFiltered = count,
                recordsTotal = count
            };
        }

        public async Task<DataTableViewModel<TResult>> GetDataTable<TResult>(int start, int lenght, Expression<Func<TEntity, bool>> search, ISpecificationSort<TEntity> sort, Expression<Func<TEntity, TResult>> select) where TResult : class
        {
            var query = context.Set<TEntity>().AsExpandable().Where(search);
            if (sort.IsAssending)
            {
                query = query.OrderBy(sort.Expression).Skip(start);
            }
            else
            {
                query = query.OrderByDescending(sort.Expression).Skip(start);

            }


            var list = await query.Take(lenght).Select(select).ToListAsync();


            var count = context.Set<TEntity>().Where(search).Count();

            return new DataTableViewModel<TResult>()
            {
                data = list,
                recordsFiltered = count,
                recordsTotal = count
            };
        }

        public async Task<DataTableViewModel<TResult>> GetDataTable<TResult>(int start, int lenght, ISpecificationFilter<TEntity> mainFilter, ISpecificationSort<TEntity> sort, Expression<Func<TEntity, TResult>> select) where TResult : class
        {
            var query = context.Set<TEntity>().AsExpandable().Where(mainFilter.GetExpression());
            if (sort.IsAssending)
            {
                query = query.OrderBy(sort.Expression).Skip(start);
            }
            else
            {
                query = query.OrderByDescending(sort.Expression).Skip(start);

            }


            var list = await query.Take(lenght).Select(select).ToListAsync();


            var count = context.Set<TEntity>().Where(mainFilter.GetExpression()).Count();

            return new DataTableViewModel<TResult>()
            {
                data = list,
                recordsFiltered = count,
                recordsTotal = count
            };
        }


        public void Update(TEntity entity)
        {
            this.context.Entry<TEntity>(entity).State = EntityState.Modified;
        }
    }
}
