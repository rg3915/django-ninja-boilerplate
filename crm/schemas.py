from ninja import ModelSchema

from .models import Person


class PersonSchema(ModelSchema):

    class Meta:
        model = Person
        fields = ('id', 'first_name', 'last_name', 'email')


class PersonCreateSchema(ModelSchema):

    class Meta:
        model = Person
        fields = ('first_name', 'last_name', 'email')
