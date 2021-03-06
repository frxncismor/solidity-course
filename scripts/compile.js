const path = require('path');
const fs = require('fs');
const solc = require('solc');
const chalk = require('chalk');

const contractPath = path.resolve(__dirname, "../contracts", "UsersContracts.sol");
const source = fs.readFileSync(contractPath, 'utf8');

const {interface, bytecode} = solc.compile(source, 1).contracts[':UsersContract'];

console.log(chalk.green(bytecode));
console.log(chalk.cyan(interface));