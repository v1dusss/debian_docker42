# 42 Docker Environment

A customizable **Debian-based Docker container** designed for students of **42** to provide quick and consistent access to a fully working Linux environment.

---

## 🚀 Features

- 🐳 **Preconfigured Docker Container** based on Debian for coding and development.
- ⚙️ **`.env` Configuration File**:
  - Set your **username** and **working directory** inside the container.
  - Choose between **detached mode** or **interactive mode**.
  - Define custom **aliases** for frequently used commands (editable in `.env`).
- 📦 **Customizable Setup Script**:
  - **Modify `start_container/script.sh` to install development tools and environments (e.g., full Python setup, C leak-checking tools).**
- 🔄 **Integration with 42 Toolbox**:
  - Uses `init_docker.sh` from the 42 Toolbox to start or reset the container.

---

## 🧰 How to Use

1. **Configure your environment**  
For normal use, just edit your username.  
Open the `.env` file and set your preferred values:

- `USERNAME`
- `WORKDIR`
- `MODE` (e.g. `detached` or `interactive`)
- `ALIASES`

2. **Default aliases**:
- `di`: `docker init` – starts Docker on your machine
- `dr`: `docker run` – includes Docker init and starts your container
- `dc`: `docker clean` – cleans up all Docker images, containers, and networks  
  ⚠️ **Be careful**: `dc` cleans not only this container, but **everything** related to Docker.

3. **First start**  
Make sure to set up the aliases in your `.zshrc` or equivalent shell config:

```bash
./run.sh
