using MyWebApi.Data;
using Microsoft.EntityFrameworkCore;

namespace MyWebApi.Services;

public interface IIdGenerationService
{
    Task<string> GenerateUserIdAsync();
    Task<string> GenerateCarrierIdAsync();
    Task<string> GenerateOrganizationIdAsync();
    Task<string> GenerateProductIdAsync();
    Task<string> GenerateRuleIdAsync();
}

public class IdGenerationService : IIdGenerationService
{
    private readonly AppDbContext _context;

    public IdGenerationService(AppDbContext context)
    {
        _context = context;
    }

    public async Task<string> GenerateUserIdAsync()
    {
        var count = await _context.Users.CountAsync();
        return $"usr-{(count + 1):D3}";
    }

    public async Task<string> GenerateCarrierIdAsync()
    {
        var count = await _context.Carriers.CountAsync();
        return $"car-{(count + 1):D3}";
    }

    public async Task<string> GenerateOrganizationIdAsync()
    {
        var userCount = await _context.Users.CountAsync();
        return $"org-{(userCount + 1):D3}";
    }

    public async Task<string> GenerateProductIdAsync()
    {
        var count = await _context.Products.CountAsync();
        return $"prod-{(count + 1):D3}";
    }

    public async Task<string> GenerateRuleIdAsync()
    {
        var count = await _context.Rules.CountAsync();
        return $"rul-{(count + 1):D3}";
    }
}