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
  - Modify `start_container/script.sh` to install development tools and environments (e.g., full Python setup, C leak-checking tools).
- 🔄 **Integration with 42 Toolbox**:
  - Uses `init_docker.sh` from the 42 Toolbox to start or reset the container.

---

## 🧰 How to Use

1. **Clone the repository**:
   ```bash
   git clone https://github.com/Jano844/debian_docker42
   cd debian_docker42
2. **Configure your environment**:
  Open .env and set your preferred:
  USERNAME
  WORKDIR
  MODE (e.g. detached or interactive)
  ALIASES
3. **First start**
   So set up the alias in your zshrc
  ```bash
  ./start_container/script.sh
