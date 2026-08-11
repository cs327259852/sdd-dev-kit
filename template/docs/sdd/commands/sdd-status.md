# sdd-status

查看当前 SDD feature 的阶段状态。

## Input

```text
sdd-status
```

完整自然语言也支持，例如：

```text
使用 sdd-status 查看当前进度
```

## Behavior

1. 读取 `AGENTS.md`、`docs/sdd/workflow.md`、`docs/sdd/commands/AGENTS.md`。
2. 解析当前 feature。
3. 读取当前 feature 下已存在的 `spec.md`、`plan.md`、`tasks.md`、`api-change.md`、`db-change.md`、`config-change.md`、`validate.md`。
4. 检查：
   - `spec.md`: `Status`、`Confirmed By`、`Confirmed At`、`Open Questions`
   - `plan.md`: `Status`、`Reviewed By`、`Reviewed At`
   - `tasks.md`: `Status`、`Approved By`、`Approved At`
   - `api-change.md` / `db-change.md` / `config-change.md`: 是否按 `plan.md` 影响范围存在或在 `tasks.md` 中说明不适用
   - `validate.md`: 是否存在阻塞性 `FAIL`

## Output

回复必须包含：

- 本命令完成了什么：读取当前 feature 状态。
- 修改了哪些文件：必须说明未修改文件。
- 当前 feature 路径。
- 已完成阶段。
- 当前阻塞门禁。
- 是否满足下一阶段门禁。
- 下一步应该执行什么命令。
- 如果不能进入下一步，说明阻塞原因和需要人工完成的动作。

禁止修改任何文件。
