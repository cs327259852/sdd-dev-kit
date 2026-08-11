# sdd-use

选择、创建或切换当前 SDD feature 目录。

## Input

推荐短命令：

```text
sdd-use {feature-name}
```

也支持：

```text
sdd-use {yyyy-mm-dd}-{feature-name}
sdd-use docs/sdd/features/{yyyy-mm-dd}-{feature-name}
使用 sdd-use 设置当前 feature：{feature-name}
```

## Behavior

1. 读取 `AGENTS.md`、`docs/sdd/workflow.md`、`docs/sdd/commands/AGENTS.md`。
2. 将输入解析为 `docs/sdd/features/{yyyy-mm-dd}-{feature-name}/`。
3. 如果用户只输入 `{feature-name}`，使用当前日期补齐目录名。
4. 如果目标目录已存在，直接选择。
5. 如果目标目录不存在，创建目录。
6. 创建 `.sdd/` 目录。
7. 将规范化后的 feature 路径写入 `.sdd/current-feature`。
8. 不生成 `spec.md`、`plan.md`、`tasks.md`、`api-change.md`、`db-change.md`、`config-change.md` 或 `validate.md`。

`.sdd/current-feature` 内容只保留一行：

```text
docs/sdd/features/{yyyy-mm-dd}-{feature-name}
```

## Stop Conditions

- 输入无法解析为 feature。
- feature 名不适合作为目录名。
- 无法创建 feature 目录。

## Output

回复必须包含：

- 本命令完成了什么：选择、创建或切换当前 feature。
- 修改了哪些文件：通常为 `.sdd/current-feature`；如果创建了 feature 目录，也必须列出。
- 当前 feature 路径。
- 目录是新建还是已存在。
- 当前 feature 处于什么状态：是否存在 `spec.md`、`plan.md`、`tasks.md`、`api-change.md`、`db-change.md`、`config-change.md`、`validate.md`。
- 是否满足下一阶段门禁。
- 下一步应该执行什么命令：
  - 如果不存在 `spec.md`，下一步是 `sdd-spec`。
  - 如果已存在 `spec.md`，下一步是 `sdd-status` 或当前缺失阶段命令。
- 如果不能进入下一步，说明阻塞原因和需要人工完成的动作。
