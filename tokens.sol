
pragma ton-solidity >= 0.35.0;
pragma AbiHeader expire;

contract Tokens {
    struct Token {
        string name;
        uint score;
        uint time;
    }
    Token[] tokensArr;
    mapping (uint => uint) tokentoOwner;
    mapping (uint => int) tokenValue;

    
    //Создание токена с уникальным именем
    function createToken(string namec, uint score, uint time) public {
        if (!tokensArr.empty()) {
            for (uint i = 0; (tokensArr.length - 1) == i; i++){
                if (tokensArr[i].name == namec) {
                    revert(105,'Токен с  таким именем уже существует');
                }   
            }
        }
        tvm.accept();
        tokensArr.push(Token(namec, score, time));
        uint key = tokensArr.length - 1;
        tokentoOwner[key] = msg.pubkey();
    }


    function setTokenValue(uint TokenId, int value) public  {
        require(msg.pubkey() == tokentoOwner[TokenId], 101);
        tvm.accept();
        tokenValue[TokenId] = value;
    }
    
}