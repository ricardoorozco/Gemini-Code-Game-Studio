# Unity Engine — Version & API Reference

| Field | Value |
|---|---|
| **Target Engine** | Unity 6 LTS (6000.0+) |
| **Primary Language** | C# 10 / 12 |
| **Target Render Pipeline** | Universal Render Pipeline (URP) |
| **Input System** | New Input System (Package `com.unity.inputsystem`) |
| **UI Framework** | UI Toolkit (`com.unity.ui`) / UGUI (`com.unity.ugui`) |

---

## Unity 6 Architectural Highlights

1. **GPU Resident Drawer & Render Graph**:
   - Unity 6 replaces legacy render passes with the Render Graph framework in URP/HDRP.
   - GPU Resident Drawer drastically cuts CPU draw call overhead for static and instanced objects.
2. **Entities 1.3+ & Burst Compiler**:
   - Modern DOTS packages provide unmanaged memory safety and fast SIMD vectorization.
3. **Multiplayer Center**:
   - Netcode for GameObjects (NGO) and Netcode for Entities (NFE) are the default networking solutions.
4. **Adaptive Performance**:
   - Mobile and standalone performance scaling based on thermal and battery profiles.

---

## Deprecated APIs to Avoid in Unity 6

- ❌ `UnityEngine.Input` (Legacy `Input.GetKey`, `Input.GetAxis` — use `UnityEngine.InputSystem`)
- ❌ `Resources.Load()` (Use Addressables: `UnityEngine.AddressableAssets.Addressables`)
- ❌ `Object.FindObjectOfType()` (Use `Object.FindFirstObjectByType()` or `Object.FindAnyObjectByType()`)
- ❌ `NetworkBehaviour` / UNet (Use Netcode for GameObjects `com.unity.netcode.gameobjects`)
- ❌ `WWW` class (Use `UnityWebRequest`)
