# Unity 6 Best Practices & Architectural Guide

## 1. ScriptableObject-Driven Architecture

In Gemini Code Game Studio, gameplay data is strictly decoupled from presentation:

```csharp
[CreateAssetMenu(fileName = "WeaponConfig", menuName = "Studio/Combat/Weapon Config")]
public class WeaponConfigSO : ScriptableObject
{
    [Header("Combat Stats")]
    [Tooltip("Base damage dealt per hit")]
    [SerializeField] private float _baseDamage = 25f;

    [Tooltip("Attack cooldown duration in seconds")]
    [SerializeField] private float _cooldown = 0.5f;

    public float BaseDamage => _baseDamage;
    public float Cooldown => _cooldown;
}
```

## 2. Event-Driven Cross-System Communication

Avoid tight dependencies between systems. Use C# events or Event ScriptableObjects:

```csharp
public class PlayerHealth : MonoBehaviour, IDamageable
{
    [SerializeField] private float _maxHealth = 100f;
    private float _currentHealth;

    public event Action<float, float> OnHealthChanged; // (current, max)
    public event Action OnDeath;

    public void TakeDamage(float amount)
    {
        _currentHealth = Mathf.Max(0, _currentHealth - amount);
        OnHealthChanged?.Invoke(_currentHealth, _maxHealth);

        if (_currentHealth <= 0)
        {
            OnDeath?.Invoke();
        }
    }
}
```

## 3. Assembly Definitions (`.asmdef`)

Keep compile times instantaneous and dependencies strictly unidirectional:
- `Studio.Core.asmdef`: Generic utilities, pooling, interfaces, base types.
- `Studio.Gameplay.asmdef`: Player, enemies, combat, economy (references `Studio.Core`).
- `Studio.UI.asmdef`: Views, HUD, menus (references `Studio.Core` and listens to events; never directly controls `Studio.Gameplay`).
- `Studio.Tests.asmdef`: NUnit test fixtures.
