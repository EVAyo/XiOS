# GitLab开启双重验证（2FA）

在 GitLab 开启双重验证（2FA）后，已有的仓库需要特别处理，尤其是在推送或拉取时，因为 GitLab 会要求使用专用的身份验证方法来代替原有的密码验证。以下是处理方式：



## 1. 使用个人访问令牌（Personal Access Tokens）

GitLab 在开启双重验证后，不再支持通过用户名和密码进行身份验证。你需要使用个人访问令牌（PAT）来代替密码。

### 步骤：

1. **生成个人访问令牌**：

    - 登录 GitLab。
    - 点击右上角的头像，选择 **Settings**（设置）。
    - 在左侧导航栏中，选择 **Access Tokens**。
    - 输入令牌的名字、选择权限（建议选择 `api` 或 `read_repository`，如果你需要推送代码，则选择 `write_repository`）。
    - 生成令牌后，**务必保存令牌**，因为你将无法再次看到它。

2. **配置 Git**： 在本地使用 Git 操作时，替换掉原本使用用户名和密码的方式，改为使用个人访问令牌：

    - 在进行 `git push` 或 `git pull` 时，GitLab 会要求你输入用户名和密码。
    - 在此处输入你的 GitLab **用户名**，然后在密码字段中使用 **个人访问令牌**（而不是 GitLab 的密码）。

    例如：

    ```bash
    git push https://gitlab.com/username/repository.git
    ```

    当提示输入密码时，输入你生成的 **个人访问令牌**。



## 2. 使用 SSH 密钥（推荐）

另一个推荐的方式是使用 **SSH 密钥**，因为 SSH 不依赖于用户名和密码验证，适合长期使用且更安全。

### 步骤：

1. **生成 SSH 密钥**（如果你还没有）： 打开终端并执行以下命令：

    ```bash
    ssh-keygen -t rsa -b 4096 -C "your_email@example.com"
    ```

    按照提示完成生成，并保存密钥。

2. **将 SSH 公钥添加到 GitLab**：

    - 登录 GitLab。
    - 进入 **Settings** > **SSH Keys**。
    - 将生成的 `id_rsa.pub` 文件内容粘贴到 **Key** 字段，点击 **Add key**。

3. **配置 Git 使用 SSH**： 将仓库的远程地址更改为 SSH 地址（如果还没有更改）：

    ```bash
    git remote set-url origin git@gitlab.com:username/repository.git
    ```

    然后你就可以使用 `git push`、`git pull` 等命令了，无需每次输入密码或令牌。



## 3. 其他注意事项

- **现有仓库**：已经存在的仓库不需要进行特别的操作，只需要在推送时使用新的身份验证方式即可。
- **CI/CD**：如果你使用 GitLab CI/CD，在 `.gitlab-ci.yml` 文件中配置的 `CI_JOB_TOKEN` 仍然有效，并且 GitLab CI 会自动使用令牌进行身份验证。
- **Token 和 SSH 密钥的选择**：如果你在多个地方（比如多个开发环境）需要操作 GitLab，使用 SSH 密钥会更方便；如果你只在某个地方进行访问，使用个人访问令牌也很方便。

通过这些方法，你可以继续无缝地管理现有的仓库，同时享受 GitLab 双重验证带来的额外安全保障。





# GitLab实操 - SSH

* [Generating a new SSH key pair](http://git.qpaas.com/help/ssh/README#generating-a-new-ssh-key-pair)





## ED25519 SSH keys

```sh
$ ssh-keygen -t ed25519 -C "597207909@qq.com"
$ ssh-keygen -t ed25519 -C "597207909@qq.com" -f ~/.ssh/id_ed25519_gitlab


# 真实
(base) ➜ ~ ssh-keygen -t ed25519 -C "597207909@qq.com" -f ~/.ssh/id_ed25519_gitlab
Generating public/private ed25519 key pair.
Enter passphrase (empty for no passphrase):
Enter same passphrase again:
Your identification has been saved in /Users/qiyeyun/.ssh/id_ed25519_gitlab
Your public key has been saved in /Users/qiyeyun/.ssh/id_ed25519_gitlab.pub
The key fingerprint is:
SHA256:u59wlonzFouuQy6vVDA87KGH0WXNcGSjIS/FPwYN8Gg 597207909@qq.com
The key's randomart image is:
+--[ED25519 256]--+
|    ooBB=        |
|   + Oo=+.       |
|  . E +o         |
|   * *  +        |
|  o o ..S.       |
|   . ..  o.o     |
|    .o  =.=o     |
|   .. o .Bo.     |
|    .+o+oo+      |
+----[SHA256]-----+
```



查看公钥

```sh
$ pbcopy < ~/.ssh/id_ed25519_gitlab.pub

# or

$ cat  ~/.ssh/id_ed25519_gitlab.pub
```



