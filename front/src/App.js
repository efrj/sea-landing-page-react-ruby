import React, { useState } from 'react';
import './App.css';
import SubscriberList from './SubscriberList';

function App() {
    const [name, setName] = useState('');
    const [email, setEmail] = useState('');

    const submitForm = () => {
        const data = {
            name,
            email
        };

        fetch('http://localhost:3001/register', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify(data)
        })
        .then(response => {
            if (response.ok) {
                console.log('Cadastro realizado com sucesso!');
                setName('');
                setEmail('');
            } else {
                console.error('Erro ao cadastrar. Verifique os dados e tente novamente.');
            }
        })
        .catch(error => {
            console.error('Erro de conexão:', error);
        });
    };

    return (
        <div className="jumbotron">
            <h1 className="text-4xl mb-4">Bem-vindo ao Nosso Mundo Subaquático!</h1>
            <p className="text-lg mb-4">Inscreva-se na nossa newsletter para receber as últimas notícias e atualizações do fundo do mar.</p>
            <hr className="my-4" />
            <form className="newsletter-form" onSubmit={(e) => { e.preventDefault(); submitForm(); }}>
                <div className="mb-4">
                    <label htmlFor="inputName" className="text-sm block">Nome</label>
                    <input
                        type="text"
                        className="w-full p-2 border rounded"
                        id="inputName"
                        placeholder="Seu nome"
                        value={name}
                        onChange={(e) => setName(e.target.value)}
                        required
                    />
                </div>
                <div className="mb-4">
                    <label htmlFor="inputEmail" className="text-sm block">Endereço de Email</label>
                    <input
                        type="email"
                        className="w-full p-2 border rounded"
                        id="inputEmail"
                        placeholder="Seu email"
                        value={email}
                        onChange={(e) => setEmail(e.target.value)}
                        required
                    />
                </div>
                <button type="submit" className="bg-blue-500 text-white p-2 rounded w-full">Inscrever-se</button>
            </form>

            <SubscriberList />
        </div>
    );
}

export default App;