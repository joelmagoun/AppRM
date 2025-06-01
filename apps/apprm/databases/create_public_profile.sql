CREATE TABLE public.profile (
  id UUID REFERENCES auth.users NOT NULL,
  email TEXT NULL,
  PRIMARY KEY (id)
);

ALTER TABLE public.profile
  ENABLE ROW LEVEL SECURITY;

CREATE POLICY
  "Can only update own profile data."
  ON public.profile
  FOR UPDATE
  USING ( auth.uid() = id );

CREATE FUNCTION
  public.create_profile_for_new_user()
  RETURNS TRIGGER AS
  $$
  BEGIN
    INSERT INTO public.profile (id, email)
    VALUES (NEW.id, NEW.email);
    RETURN NEW;
  END;
  $$ LANGUAGE plpgsql SECURITY DEFINER;


CREATE TRIGGER
  create_profile_on_signup
  AFTER INSERT ON auth.users
  FOR EACH ROW
  EXECUTE PROCEDURE
    public.create_profile_for_new_user();