import { createContext, useState } from "react";

const connect = () => {
    if (typeof (window.ethereum) === 'undefined') {
        return setStatus('not_installed');
    }

Promise.all([
    window.ethereum.request({ method: 'eth_requestAccounts'}),
    window.ethereum.request({ method: 'eth_chainId'}),
]).then(function ([accounts, chainId])) {
    setAccount(accounts[0]);
    setChain(chainId);
    setStatus('connected');
}
    .catch(function (error) {
        console.error(error)
    });
}