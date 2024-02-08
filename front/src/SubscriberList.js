import React, { useState, useEffect } from 'react';

function SubscriberList() {
  const [subscribers, setSubscribers] = useState([]);

  useEffect(() => {
    const fetchData = async () => {
      try {
        const response = await fetch('http://localhost:3001/list');
        const data = await response.json();
        setSubscribers(data.reverse());
      } catch (error) {
        console.error('Erro ao buscar dados:', error);
      }
    };

    fetchData();

    const intervalId = setInterval(fetchData, 1000);

    return () => clearInterval(intervalId);
  }, []);

  return (
    <div className="subscriber-list mt-10">
      <h2 className="text-2xl mb-4">Lista de Inscritos</h2>
      <div className="scrollable-list">
        <ul className="pb-8">
          {subscribers.map(subscriber => (
            <li key={subscriber.id}>
              <strong>{subscriber.name}</strong> - <a href={`mailto:${subscriber.email}`}>{subscriber.email}</a>
            </li>
          ))}
        </ul>
      </div>
    </div>
  );
}

export default SubscriberList;