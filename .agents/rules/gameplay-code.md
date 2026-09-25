---
paths:
  - "Assets/Scripts/Gameplay/**"
---

# Gameplay Code Standards (Unity C#)

- **Data-Driven Values**: ALL gameplay numbers (damage, speed, jump height, cooldowns) MUST be stored in `ScriptableObject` assets or serialized config fields. Never hardcode magic numbers.
- **Time Independence**: Use `Time.deltaTime` for frame-dependent updates and `Time.fixedDeltaTime` for physics updates.
- **Decoupled Architecture**: Gameplay systems must NEVER directly call UI scripts or hold UI references. Emit C# `event Action` or use event ScriptableObjects.
- **Zero Allocations in Hot Paths**: `Update()` and `FixedUpdate()` must produce 0 bytes of heap garbage (`GC.Alloc`).
  - Do NOT use LINQ, string concatenation, or boxing in loops.
  - Use `Physics.RaycastNonAlloc` instead of `Physics.RaycastAll`.
- **Object Pooling**: Pre-instantiate and recycle repeated objects (bullets, impacts, floating text) using `UnityEngine.Pool.ObjectPool<T>`.
- **Null Safety**: Always check for `null` using standard Unity comparisons (`myObj != null`).
