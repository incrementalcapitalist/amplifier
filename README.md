---

# AWS Amplify Starter Template

This repository provides a starter template for AWS Amplify development. It includes bash scripts that automate the setup of the necessary tools and configuration for AWS Amplify on a new environment, supporting both Generation 1 (Gen 1) and Generation 2 (Gen 2) Amplify configurations.

## Table of Contents

1. [Prerequisites](#prerequisites)
2. [Repository Contents](#repository-contents)
3. [Setup Instructions](#setup-instructions)
   - [Copy AWS Credentials](#1-copy-aws-credentials)
   - [Clone the Repository](#2-clone-the-repository)
   - [Run the Initialization Script](#3-run-the-initialization-script)
4. [Script Workflow](#script-workflow)
5. [Verify Installation](#verify-installation)
6. [Start Developing with AWS Amplify](#start-developing-with-aws-amplify)
7. [Script Details](#script-details)
   - [AWS Credentials Transfer](#aws-credentials-transfer)
   - [Amplify Setup Script Selector](#amplify-setup-script-selector)
   - [Gen 1 Setup Script](#gen-1-setup-script)
   - [Gen 2 Setup Script](#gen-2-setup-script)
8. [Troubleshooting](#troubleshooting)
9. [Contributing](#contributing)
10. [License](#license)

## Prerequisites

Before running the setup scripts, ensure you have the following:

- An **AWS account** with sufficient permissions to create and manage Amplify projects.
- Access to an **Ubuntu** environment (local or EC2 instance) with internet connectivity.

## Repository Contents

- `transfer-aws-configuration.bash`: Script to securely transfer AWS credentials to a remote server [run from your MacBook Pro].
- `initialize.bash`: Main script to choose between Gen 1 and Gen 2 Amplify setup.
- `amplify-gen1-setup-script.bash`: Script to set up a Gen 1 Amplify project.
- `amplify-gen2-setup-script.bash`: Script to set up a Gen 2 Amplify project.

## Setup Instructions

### 1. Copy AWS Credentials

If using a remote environment, set up the SSH config file and copy AWS credentials using the `transfer-aws-configuration.bash` script:

```bash
bash transfer-aws-configuration.bash
```

### 2. Clone the Repository

Clone this repository to your local machine or remote environment:

```bash
git clone https://github.com/incrementalcapitalist/amplifier.git
cd amplifier
```

### 3. Run the Initialization Script

Run the Amplify setup selector script:

```bash
bash initialize.bash
```

## Script Workflow

When you run the script, it will perform the following actions:

1. **Prompt for Project Name and Type:**
   - You will be asked to enter a name for your AWS Amplify project and choose between Gen 1 and Gen 2 setup.

2. **System Update and Upgrade:**
   - Updates the package index and performs a full system upgrade.

3. **Install Dependencies:**
   - Installs `unzip` and `curl`.

4. **Install AWS CLI:**
   - Downloads and installs the AWS CLI (version 2).

5. **Install Node Version Manager (NVM) and Node.js:**
   - Installs NVM and the latest stable version of Node.js and npm.

6. **Install Amplify CLI:**
   - Installs the Amplify CLI globally using npm.

7. **AWS CLI and Amplify CLI Configuration:**
   - Configures AWS CLI with your credentials.
   - Sets up AWS Amplify for use in your projects.

8. **Initialize a New Amplify Project:**
   - Creates a directory with the provided name and initializes a new Amplify project.

## Verify Installation

After running the script, verify the installation:

```bash
nvm -v
node -v
npm -v
aws --version
amplify --version
```

## Start Developing with AWS Amplify

Navigate to the newly created Amplify project directory:

```bash
cd your-project-name
```

Replace `your-project-name` with the name you provided during script execution.

## Script Details

### AWS Credentials Transfer

The `transfer-aws-configuration.bash` script securely copies your local AWS credentials to a remote server.

### Initialize (The Amplify Setup Script Selector)

The `initialize.bash` script allows you to choose between setting up a Gen 1 or Gen 2 Amplify project.

### Gen 1 Setup Script

The `amplify-gen1-setup-script.bash` sets up a Gen 1 Amplify project.

### Gen 2 Setup Script

The `amplify-gen2-setup-script.bash` sets up a Gen 2 Amplify project, prompting for the Amplify App ID and branch name.

## Troubleshooting

- **AWS CLI or Amplify CLI not recognized**: Ensure that your PATH is correctly set. You can manually add paths to your `.bashrc` or `.bash_profile` if necessary.
- **Permission Denied Errors**: Make sure you are running the script with sufficient permissions (`sudo` may be required for some commands).
- **Script Errors:** If any errors occur during script execution, they will be logged. Review the log for troubleshooting.

## Contributing

If you encounter any issues or have suggestions for improvements, feel free to open an issue or submit a pull request.

## License

This project is licensed under the GNU General Public License (GPL) v3.0. See the [LICENSE](LICENSE) file for more information.

### Why GPL v3?

The GPL v3 license enforces strong copyleft requirements and ensures that all derivative works of this project remain open source. This license also provides additional protections against patent claims, which aligns with the goal to keep contributions and derivatives freely available and to safeguard the project's integrity and freedom.

---