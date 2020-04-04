class Exam < ApplicationRecord
  belongs_to :patient

  belongs_to :point_po, class_name: "Point", :foreign_key => 'point_po_id', dependent: :destroy
  belongs_to :point_or, class_name: "Point", :foreign_key => 'point_or_id', dependent: :destroy
  belongs_to :point_a, class_name: "Point", :foreign_key => 'point_n_id', dependent: :destroy
  belongs_to :point_n, class_name: "Point", :foreign_key => 'point_a_id', dependent: :destroy

  accepts_nested_attributes_for :point_po
  accepts_nested_attributes_for :point_or
  accepts_nested_attributes_for :point_n
  accepts_nested_attributes_for :point_a
 
  #used in show.html.erb
  def retaAN
    @retaAN = 0.0 
    retaAN = Math.atan((point_a.y - point_n.y)/(point_a.x - point_n.x))
    return retaAN
  end

  #used in show.html.erb
  def retaOrPo
    @retaOrPo = 0.0
    retaOrPo = Math.atan((point_or.y - point_po.y)/(point_or.x - point_po.x))
    return retaOrPo
  end


  def maxillary_depth_angle
    @retaAN = 0.0   
    @retaOrPo = 0.0
    @max_angle = 0.0
    
    
    retaAN = (point_a.y - point_n.y)/(point_a.x - point_n.x)

    retaOrPo = (point_or.y - point_po.y)/(point_or.x - point_po.x)

    max_angle = Math.atan(((retaOrPo - retaAN)/(1 + retaOrPo * retaAN)))*(180.0/Math::PI)

    #the code under considers all face's position (left or right)
    #left side
    if max_angle < 0
      return max_angle + 180.0
    #right side
    elsif max_angle > 0
      return max_angle
    else 
      return nil if self.point_po.x.nil? or self.point_po.y.nil? or self.point_or.x.nil? or self.point_or.y.nil? or self.point_n.x.nil? or self.point_n.y.nil? or self.point_a.x.nil? or self.point_a.y.nil?
    end
  end
end

