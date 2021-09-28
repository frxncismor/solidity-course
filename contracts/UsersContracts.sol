pragma solidity ^0.4.24;

contract UsersContract {
    // Crear tipos complejos con struct
    struct User {
        string name;
        string surName;
    }

    // Mapping se declaran como <KeyType, ValueType>, pueden ser
    // KeyType: Cualquier tipo de dato excepto Dynamics Arrays, Mapping, Contracts y Enums
    // ValueType: Todos los tipos de datos, incluidos mappings

    mapping(address => User) private users;
    mapping(address => bool) private joinedUsers;
    address[] total;

    // Eventos nos permite "dibujar" en tiempo real los datos que le pasemos.
    event onUserJoined(address, string);

    function join(string name, string surName) public {
        require(!userJoined(msg.sender));
        User storage user = users[msg.sender];
        user.name = name;
        user.surName = surName;
        joinedUsers[msg.sender] = true;
        total.push(msg.sender);

        // Aqui hicimos uso del evento onUserJoined para que mostremos en los logs, la address y el nombre completo concatenado
        emit onUserJoined(
            msg.sender,
            string(abi.encodePacked(name, " ", surName))
        );
    }

    // Obtenemos usuario ingresando la address y devolviendo el nombre y apellido del usuario registrado con esa address
    function getUser(address addr) public view returns (string, string) {
        require(userJoined(msg.sender));
        User memory user = users[addr];
        return (user.name, user.surName);
    }

    // Buscamos en joinedUsers la address del usuario que esta mandando la peiticion
    function userJoined(address addr) private view returns (bool) {
        return joinedUsers[addr];
    }

    // Devolvemos la cantidad de usuarios registrados
    function totalUsers() public view returns (uint256) {
        return total.length;
    }
}
