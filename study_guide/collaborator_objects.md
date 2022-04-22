# Collaborator Objects #

**Collaborator object**
: an object that is stored as a *state*(i.e. within an instance variable) within another object. They are called *collaborators* because they work in conjunction with the class they are associated with.

Collaborator objects are usually *custon* objects(i.e. defined by programmer and not built into Ruby). Technically, a string or other built in object type that saves as a value in an instance variable would still be a collaborator object but we don't really tend to think of them that way

Collaborator object *represent the connections between various actors in the program*. When thinking about how to stucture various classes, objects, and all the ways in which they might connect, thing about:

- What collaborators will a custom class need?
- Do the associations between a custom class and its collaborators make sense?
- What makes sense here technically?
- What makes sense here with respect to modeling the problem we are attempting to solve?

At the end of the day, collaborator object allow us to chop up and modularize the problem domain into cohesive pieces.
