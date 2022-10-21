using System.Linq.Expressions;

namespace WebShopping.Specification.Interfaces
{
    public interface ISpecificationFilter<TEntity>
    {

        public Expression<Func<TEntity, bool>> GetExpression();
    }
}
