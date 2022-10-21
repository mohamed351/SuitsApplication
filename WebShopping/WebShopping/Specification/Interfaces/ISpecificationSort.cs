using System.Linq.Expressions;

namespace WebShopping.Specification.Interfaces
{
    public interface ISpecificationSort<TEntity>
    {
        public bool IsAssending { get; set; }
        public string Property { get; set; }

        public Expression<Func<TEntity, dynamic>> Expression { get; }
    }
}
