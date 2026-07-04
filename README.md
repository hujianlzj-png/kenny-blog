# kenny-blog

> 基于 Hugo + Blowfish 主题的个人博客，部署在 Cloudflare Pages。

## 技术栈

- **框架**: [Hugo](https://gohugo.io/) (静态站点生成器)
- **主题**: [Blowfish](https://blowfish.page/)
- **部署**: 
  - Cloudflare Pages (主站: https://kenny-blog.pages.dev)
  - GitHub: https://github.com/hujianlzj-png/kenny-blog
  - Gitee: https://gitee.com/swjtuannon/kenny-blog

## 快速开始

```bash
# 1. 克隆仓库
git clone git@github.com:hujianlzj-png/kenny-blog.git
cd hugo-blog

# 2. 启动本地开发服务器
hugo server -D

# 3. 创建新文章
hugo new content blog/my-new-post.md

# 4. 构建并部署
.\deploy.ps1
```

## 目录结构

```
hugo-blog/
├── config/_default/   # Hugo 配置
├── content/           # 文章内容 (Markdown)
├── assets/            # 自定义资源 (CSS/JS/图片)
├── static/            # 静态文件
├── themes/blowfish/   # 主题 (Git Submodule)
├── deploy.ps1         # 一键部署脚本
└── .gitee/workflows/  # CI/CD
```

## 写作规范

- 文章使用 `.md` 格式，放在 `content/blog/` 下
- 每篇文章需要 frontmatter: `title`, `date`, `tags`, `description`
- 图片放在 `static/img/` 下，引用路径为 `/img/xxx.png`

## 双仓库同步

`deploy.ps1` 脚本会自动构建 Hugo 站点并推送到 GitHub 和 Gitee 两个远程仓库。

Cloudflare Pages 监听 GitHub 仓库自动部署，Gitee Pages 需要手动在 Gitee 后台更新。
