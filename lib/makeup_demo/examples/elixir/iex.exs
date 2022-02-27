# Normal IEx session
iex> 1+2
3

iex> 1/0
** (ArithmeticError) bad argument in arithmetic expression
    :erlang./(1, 0)


iex> changeset = User.changeset(%User{}, %{})
#Ecto.Changeset<action: nil, changes: %{},
  errors: [name: {"can't be blank", [validation: :required]},
   email: {"can't be blank", [validation: :required]},
   bio: {"can't be blank", [validation: :required]}],
  data: #Hello.User<>, valid?: false>

# Same as above, but with numbers:
iex(1)> 1+2
3

iex(2)> 1/0
** (ArithmeticError) bad argument in arithmetic expression
    :erlang./(1, 0)


iex(3)> changeset = User.changeset(%User{}, %{})
#Ecto.Changeset<action: nil, changes: %{},
  errors: [name: {"can't be blank", [validation: :required]},
   email: {"can't be blank", [validation: :required]},
   bio: {"can't be blank", [validation: :required]}],
  data: #Hello.User<>, valid?: false>
