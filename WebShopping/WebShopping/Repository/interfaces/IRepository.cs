using System.Linq.Expressions;
using WebShopping.Specification.Interfaces;

namespace WebShopping.Repository.interfaces
{
    public interface IRepository<TEntity, TKey> where TEntity : class
    {
        Task<IEnumerable<TEntity>> GetAllAsync();

        Task<TEntity> GetByID(TKey key);

        void Add(TEntity entity);
        Task<DataTableViewModel<TEntity>> GetDataTable(int start, int lenght, Expression<Func<TEntity, bool>> search, Expression<Func<TEntity, TKey>> OrderBy);
        Task<DataTableViewModel<TResult>> GetDataTable<TResult>(int start, int lenght, Expression<Func<TEntity, bool>> search,
            ISpecificationSort<TEntity> sort,
            Expression<Func<TEntity, TResult>> select) where TResult : class;

        public  Task<DataTableViewModel<TResult>> GetDataTable<TResult>(int start, int lenght, Expression<Func<TEntity, bool>> search, Expression<Func<TEntity, TKey>> OrderBy, Expression<Func<TEntity, TResult>> select) where TResult : class;


Task<DataTableViewModel<TResult>> GetDataTable<TResult>(int start,
        int lenght, ISpecificationFilter<TEntity> mainFilter,
         ISpecificationSort<TEntity> sort, Expression<Func<TEntity, TResult>> select) where TResult : class;

        void Update(TEntity entity);

        void Delete(TEntity entity);


    }
    /// <summary>
    /// DataTable ViewModel i didn't use Naming Convention in this class because they what their own name
    /// </summary>
    /// <typeparam name="T">The class that will apply on Data Table</typeparam>
    public class DataTableViewModel<T> where T : class
    {
        /// <summary>
        /// The Data whether the Model or Brand , etc
        /// That class is  generic
        /// </summary>
        public IEnumerable<T>? data { get; set; }
        /// <summary>
        /// The Total Number of Filtered Records 
        /// </summary>
        public int recordsFiltered { get; set; }
        /// <summary>
        /// The Total Number of Records
        /// </summary>
        public int recordsTotal { get; set; }

    }
}
