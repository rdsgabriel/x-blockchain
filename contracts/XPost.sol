// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.19;

import "hardhat/console.sol";

contract XPost {
    uint256 totalPosts;
    uint256 private seed;

    event NewPost(address indexed from, uint256 timestamp, string message);

    struct Post {
        address sender;
        string message;
        uint256 timestamp;
    }

    Post[] posts;

    // o usuário só poderá postar a cada 30 segundos (para diminuir spam)
    mapping(address => uint256) public lastPostedAt;

    constructor() payable {
        console.log("O contrato foi criado!");
        // Essa "seed" é um número aleatório entre 1 e 100 que vai determinar se o usuário vai ou não ganhar um prêmio no post que ele fez
        seed = (block.timestamp + block.prevrandao) % 100;
    }

    function createPost(string memory _message) public {
        // conferindo se o mesmo usuário (mesmo endereço) está tentando criar mais de um post em menos de 30 segundos
        require(lastPostedAt[msg.sender] + 30 seconds < block.timestamp, "Must wait 30 seconds before waving again.");


        // salvando a data e hora do último post para ser usado nessa função de cima
        lastPostedAt[msg.sender] = block.timestamp;
        totalPosts += 1;
        console.log("%s criou um post!", msg.sender);

        // salvando o post na blockchain, todos os posts salvos poderão ser lidos no front-end
        posts.push(Post(msg.sender, _message, block.timestamp));

        // atualizando a "seed" (número aleatório) para a descobrir se a pessoa ganhou ou não o prêmio
        seed = (block.prevrandao + block.timestamp + seed) % 100;

        if (seed <= 50) {
            console.log("%s ganhou um premio de 0.0001 Ethereum!", msg.sender);

            uint256 prizeAmount = 0.0001 ether;
            require(
                prizeAmount <= address(this).balance,
                "O contrato nao tem fundos suficience para pagar o premio."
            );
            (bool success, ) = (msg.sender).call{value: prizeAmount}("");
            require(success, "Nao foi possivel enviar o premio.");
        }

        // Toda vez que alguém criar um post, esse evento NewPost vai ser disparado e poderá ser "escutado" pelo front-end para atualizar os posts em "tempo real"
        emit NewPost(msg.sender, block.timestamp, _message);
    }

    function getAllPosts() public view returns (Post[] memory) {
        return posts;
    }

    function getTotalPosts() public view returns (uint256) {
        console.log("Eu tenho %d posts!", totalPosts);
        return totalPosts;
    }
}
