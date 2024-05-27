from http import HTTPStatus

import pytest


@pytest.mark.django_db
def test_healthcheck(client):
    """
    Testa o endpoint healthcheck.
    Testa se retorna status_code 200.
    Testa se retorna {'status': 'ok'}
    """
    response = client.get('/api/v1/healthcheck')
    expected = {'status': 'ok'}

    assert response.status_code == HTTPStatus.OK
    assert response.json() == expected
