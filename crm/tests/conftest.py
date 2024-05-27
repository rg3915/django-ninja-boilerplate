import pytest


@pytest.fixture
def person():
    return {
        'first_name': 'Pedrinho',
        'last_name': 'Silva',
        'email': 'pedrinho@email.com',
    }
