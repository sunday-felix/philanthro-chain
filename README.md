# PhilanthroChain - Transparent Impact Protocol

![Stacks](https://img.shields.io/badge/Stacks-5546FF?style=for-the-badge&logo=stacks&logoColor=white)
![Clarity](https://img.shields.io/badge/Clarity-Smart%20Contract-orange?style=for-the-badge)
![License](https://img.shields.io/badge/License-ISC-blue?style=for-the-badge)

## 🌟 Overview

PhilanthroChain is a revolutionary decentralized infrastructure that transforms how communities contribute to philanthropic causes. Built on the Stacks blockchain, it enables frictionless donations, transparent fund management, and milestone-based accountability, ensuring every contribution is both visible and verifiable.

### 🎯 Mission

To create a trustless philanthropy ecosystem that eliminates traditional bottlenecks in charitable giving by leveraging blockchain technology for permanent, auditable ledgers of donations, beneficiaries, and fund utilization.

## 🏗️ System Architecture

### Contract Architecture

```text
PhilanthroChain Smart Contract
├── Access Control Layer
│   ├── Role-Based Permissions (Admin, Moderator, Beneficiary)
│   └── Contract Ownership Management
├── Beneficiary Management
│   ├── Registration System
│   ├── Target Amount Tracking
│   └── Status Management
├── Donation Processing
│   ├── STX Transfer Handling
│   ├── Transaction Recording
│   └── Automatic Balance Updates
└── Fund Utilization
    ├── Milestone Creation
    ├── Approval Workflow
    └── Transparency Tracking
```

### Core Components

#### 1. **Access Control System**

- **Admin Role**: Full contract management and oversight
- **Moderator Role**: Beneficiary registration and management
- **Beneficiary Role**: Limited access for fund recipients

#### 2. **Beneficiary Registry**

- Comprehensive beneficiary profiles with descriptions and funding targets
- Real-time tracking of received donations vs. target amounts
- Status management (active, completed, suspended)

#### 3. **Donation Engine**

- Seamless STX token transfers to contract escrow
- Immutable donation history with timestamp and donor information
- Automatic beneficiary balance updates

#### 4. **Utilization Framework**

- Milestone-based fund release system
- Administrative approval workflow for fund utilization
- Transparent tracking of how funds are used

## 📊 Data Flow

```mermaid
graph TD
    A[Donor] -->|donate()| B[Smart Contract]
    B -->|STX Transfer| C[Contract Escrow]
    B -->|Update Balance| D[Beneficiary Record]
    B -->|Record Transaction| E[Donation History]
    
    F[Admin] -->|add-utilization()| G[Utilization Proposal]
    G -->|approve-utilization()| H[Milestone Approval]
    H -->|Status Update| I[Transparent Record]
    
    J[Moderator] -->|register-beneficiary()| K[New Beneficiary]
    K -->|Available for| L[Public Donations]
```

## 🔧 Technical Specifications

### Data Structures

#### Beneficiary Registry

```clarity
{
  name: (string-utf8 50),
  description: (string-utf8 255),
  target-amount: uint,
  received-amount: uint,
  status: (string-ascii 20)
}
```

#### Donation Records

```clarity
{
  donor: principal,
  beneficiary-id: uint,
  amount: uint,
  timestamp: uint
}
```

#### Fund Utilization

```clarity
{
  beneficiary-id: uint,
  milestone: uint,
  description: (string-utf8 255),
  amount: uint,
  status: (string-ascii 20)
}
```

### Error Codes

| Code | Error | Description |
|------|-------|-------------|
| u100 | `ERR-NOT-AUTHORIZED` | Insufficient permissions for operation |
| u101 | `ERR-ALREADY-REGISTERED` | Entity already exists in system |
| u102 | `ERR-NOT-FOUND` | Requested resource not found |
| u103 | `ERR-INSUFFICIENT-FUNDS` | Insufficient balance for operation |
| u104 | `ERR-BENEFICIARY-NOT-FOUND` | Beneficiary ID does not exist |
| u105 | `ERR-UTILIZATION-NOT-FOUND` | Utilization record not found |
| u106 | `ERR-INVALID-INPUT` | Invalid parameters provided |

## 🚀 Getting Started

### Prerequisites

- [Clarinet](https://github.com/hirosystems/clarinet) - Stacks development environment
- [Node.js](https://nodejs.org/) (v16 or higher)
- [Stacks Wallet](https://wallet.hiro.so/) for testing

### Installation

1. **Clone the repository**

   ```bash
   git clone https://github.com/sunday-felix/philanthro-chain.git
   cd philanthro-chain
   ```

2. **Install dependencies**

   ```bash
   npm install
   ```

3. **Run contract checks**

   ```bash
   clarinet check
   ```

4. **Execute tests**

   ```bash
   npm test
   ```

### Development Setup

1. **Start Clarinet console**

   ```bash
   clarinet console
   ```

2. **Deploy contract locally**

   ```clarity
   (contract-call? .philanthro-chain register-beneficiary 
     u"Local Charity" 
     u"Supporting local community development" 
     u1000000)
   ```

## 📋 API Reference

### Public Functions

#### Role Management

- `set-role(user: principal, new-role: uint)` - Assign role to user (Admin only)
- `remove-role(user: principal)` - Remove user role (Admin only)

#### Beneficiary Operations

- `register-beneficiary(name, description, target-amount)` - Register new beneficiary (Moderator+)
- `get-beneficiary(id: uint)` - Retrieve beneficiary information

#### Donation Functions

- `donate(beneficiary-id: uint, amount: uint)` - Process donation to beneficiary
- `get-donation-by-id(donation-id: uint)` - Get donation details
- `get-donation-count()` - Get total number of donations

#### Utilization Management

- `add-utilization(beneficiary-id, description, amount)` - Create utilization proposal (Admin only)
- `approve-utilization(beneficiary-id, milestone)` - Approve fund utilization (Admin only)
- `get-utilization-by-id(utilization-id: uint)` - Get utilization details
- `get-utilization-count()` - Get total utilization count

### Read-Only Functions

All getter functions are read-only and don't require transaction fees:

- `get-beneficiary(id)`
- `get-donation-by-id(id)`
- `get-utilization-by-id(id)`
- `get-donation-count()`
- `get-utilization-count()`

## 🧪 Testing

### Running Tests

```bash
# Run all tests
npm test

# Run tests with coverage
npm run test:report

# Watch mode for development
npm run test:watch
```

### Test Structure

tests/
└── philanthro-chain.test.ts    # Comprehensive contract tests

### Example Test Cases

- Role assignment and authorization
- Beneficiary registration workflow
- Donation processing and balance updates
- Fund utilization approval system
- Error handling and edge cases

## 🔐 Security Considerations

### Access Control

- **Hierarchical Permissions**: Admin > Moderator > Beneficiary roles
- **Owner Protection**: Contract owner cannot be modified or removed
- **Authorization Checks**: All sensitive operations require proper role verification

### Fund Safety

- **Escrow System**: All donations held in contract escrow until utilization
- **Milestone Approval**: Funds can only be utilized through approved milestones
- **Balance Verification**: Utilization amounts verified against available balances

### Data Integrity

- **Immutable Records**: All donations and utilizations permanently recorded
- **Validation**: Input validation on all user-provided data
- **Overflow Protection**: Safe arithmetic operations throughout

## 🌐 Deployment

### Testnet Deployment

1. **Configure Clarinet.toml**

   ```toml
   [network.testnet]
   stacks_node_rpc_address = "https://stacks-node-api.testnet.stacks.co"
   ```

2. **Deploy contract**

   ```bash
   clarinet deployments generate --testnet
   clarinet deployments apply --testnet
   ```

### Mainnet Deployment

1. **Update network configuration**
2. **Comprehensive testing on testnet**
3. **Security audit completion**
4. **Deploy to mainnet**

## 🤝 Contributing

We welcome contributions to PhilanthroChain! Please see our [Contributing Guidelines](CONTRIBUTING.md) for details.

### Development Workflow

1. Fork the repository
2. Create a feature branch
3. Write tests for new functionality
4. Ensure all tests pass
5. Submit a pull request

## 📄 License

This project is licensed under the ISC License - see the [LICENSE](LICENSE) file for details.

## 🔗 Links

- [Stacks Documentation](https://docs.stacks.co/)
- [Clarity Language Reference](https://docs.stacks.co/clarity/)
- [Clarinet Documentation](https://github.com/hirosystems/clarinet)
