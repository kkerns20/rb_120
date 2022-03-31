class MeMyselfAndI
  self

  def self.me
    p self
  end

  def myself
    p self
  end
end

i = MeMyselfAndI.new
MeMyselfAndI.me
i.myself