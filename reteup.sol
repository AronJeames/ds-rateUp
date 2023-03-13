pragma solidity ^0.8.0;

interface jugLike {
    function ilks(bytes32 ilk) external returns (uint256 duty, uint256 rho);
    function drip(bytes32 ilk) external returns (uint256 rate);
}

interface vatLike {
    function ilks(bytes32 ilk) external  returns (uint256 art, uint256 rate, uint256 spot, uint256 line,uint256 dust);
}

contract rateup {
    function GetilkDebt(address vat, bytes32 ilk) external returns(uint256 art) {
        (art, , , ,) = vatLike(vat).ilks(ilk);
    }

    function Rateup(address jug, bytes32[] calldata ilks) external {
        if( ilks.length == 0 ) {
            return;
        }

        for( uint i = 0; i < ilks.length - 1; i++ ) {
            // jugLike(jug).ilks(ilks[i]);
            jugLike(jug).drip(ilks[i]);
        }
    }

}
