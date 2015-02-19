<?php
//\Configure::pre($typ__);
?>
<div class="page-header">
	<h1><?php echo $this->Html->Url($this->Html->__t("Squads"), array("action" => "index", "admin" => true)); ?> - <?php echo $typ__["data"]["squads"]["name"]; ?></h1>
</div>

<div class="raceTypes view">
	<div class="panel panel-default">
		<div class="panel-heading">
			<?php echo $this->Html->__t("Squads view"); ?>
			<span class="pull-right">
				<?php echo $this->Html->Url($this->Html->__t("Edit"), array("action" => "edit", "admin" => true, "params" => array($typ__["data"]["squads"]["id"])), array("class" => "btn-sm btn-warning")); ?>
				<?php echo $this->Html->UrlPost($this->Html->__t("Delete"), array("admin" => true, "action" => "delete", "params" => array($typ__["data"]["squads"]["id"])), array("class" => "btn-sm btn-danger"), $this->Html->__t("Are you sure you want to delete this record?")); ?>
			</span>
		</div>
		<div class="panel-body">
			<div class="row">
				<span class="col-md-3"><?php echo $this->Html->__t("Name"); ?></span>
				<span class="col-md-9"><?php echo $typ__["data"]["squads"]["name"]; ?></span>
			</div>
			<div class="row">
				<span class="col-md-3"><?php echo $this->Html->__t("Army"); ?></span>
				<span class="col-md-9">
					<?php echo $this->Html->Url($typ__["data"]["squads"]["army_name"], array("controller" => "armies", "action" => "view", "admin" => true, "params" => array($typ__["data"]["squads"]["army_id"]))); ?>
				</span>
			</div>
			<div class="row">
				<span class="col-md-3"><?php echo $this->Html->__t("Type"); ?></span>
				<span class="col-md-9">
					<?php echo $this->Html->Url($typ__["data"]["squads"]["type_name"], array("controller" => "types", "action" => "view", "admin" => true, "params" => array($typ__["data"]["squads"]["type_id"]))); ?>
				</span>
			</div>
			<div class="row">
				<span class="col-md-3"><?php echo $this->Html->__t("Created"); ?></span>
				<span class="col-md-9"><?php echo $this->Html->Time("TimeAgo", $typ__["data"]["squads"]["created"]); ?></span>
			</div>
			<div class="row">
				<span class="col-md-3"><?php echo $this->Html->__t("Modified"); ?></span>
				<span class="col-md-9"><?php echo $this->Html->Time("TimeAgo", $typ__["data"]["squads"]["modified"]); ?></span>
			</div>
		</div>
	</div>
</div>



<?php
if(isset($typ__["data"]["squads"]["squadunits"])) {
	foreach($typ__["data"]["squads"]["squadunits"] as $squadunit) {
		$panel = "panel-success";
		if(!isset($squadunit["min_count"]) && !isset($squadunit["max_count"]))
		$panel = "panel-danger";
?>
<div class="raceTypes view">
	<div class="panel <?php echo $panel; ?>">
		<div class="panel-heading">
			<?php echo $this->Html->__t("Squad Unit information"); ?> - <?php echo $squadunit['name'];?>
			<span class="pull-right">
				<?php echo $this->Html->Url($this->Html->__t("Edit"), array("controller" => "SquadUnits", "action" => "edit", "admin" => true, "params" => array($squadunit["id"], $typ__["data"]["squads"]["id"])), array("class" => "btn-sm btn-warning")); ?>
				<?php echo $this->Html->UrlPost($this->Html->__t("Delete"), array("admin" => true, "controller" => "SquadUnits", "action" => "delete", "params" => array($squadunit["id"], $typ__["data"]["squads"]["id"])), array("class" => "btn-sm btn-danger"), $this->Html->__t("Are you sure you want to delete this record?")); ?>
			</span>
		</div>

				<table class="table table-striped table-bordered table-listings">
					<tr>
						<th><?php echo $this->Html->__t('Name'); ?></th>
						<?php
						if($squadunit['units']['front_armour'] == 0) {
						?>
						<th><?php echo $this->Html->__t('WS'); ?></th>
						<th><?php echo $this->Html->__t('BS'); ?></th>
						<th><?php echo $this->Html->__t('S'); ?></th>
						<th><?php echo $this->Html->__t('T'); ?></th>
						<th><?php echo $this->Html->__t('I'); ?></th>
						<th><?php echo $this->Html->__t('W'); ?></th>
						<th><?php echo $this->Html->__t('A'); ?></th>
						<th><?php echo $this->Html->__t('Ld'); ?></th>
						<th><?php echo $this->Html->__t('S'); ?></th>
						<th><?php echo $this->Html->__t('Is'); ?></th>
						<!--th><?php //echo $this->Html->__t('Pts'); ?></th-->
						<?php
						} else {
						?>
						<th><?php echo $this->Html->__t('WS'); ?></th>
						<th><?php echo $this->Html->__t('BS'); ?></th>
						<th><?php echo $this->Html->__t('S'); ?></th>
						<th><?php echo $this->Html->__t('FA'); ?></th>
						<th><?php echo $this->Html->__t('SA'); ?></th>
						<th><?php echo $this->Html->__t('RA'); ?></th>
						<th><?php echo $this->Html->__t('I'); ?></th>
						<th><?php echo $this->Html->__t('A'); ?></th>
						<th><?php echo $this->Html->__t('HP'); ?></th>
						<!--th><?php //echo $this->Html->__t('Pts'); ?></th-->
						<?php
						}
						?>

						<th><?php echo $this->Html->__t('Created'); ?></th>
						<th><?php echo $this->Html->__t('Modified'); ?></th>
						<th class="actions"><?php echo $this->Html->__t('Actions');?></th>
					</tr>

					<tr>
						<td><?php echo $squadunit['name'];?></td>
						<?php
						if($squadunit['units']['front_armour'] == 0) {
						?>
						<td><?php echo $squadunit['units']['weapon_skill'];?></td>
						<td><?php echo $squadunit['units']['ballistic_skill'];?></td>
						<td><?php echo $squadunit['units']['strength'];?></td>
						<td><?php echo $squadunit['units']['toughness'];?></td>
						<td><?php echo $squadunit['units']['initiative'];?></td>
						<td><?php echo $squadunit['units']['wounds'];?></td>
						<td><?php echo $squadunit['units']['attacks'];?></td>
						<td><?php echo $squadunit['units']['leadership'];?></td>
						<td><?php echo $squadunit['units']['armour_save'];?></td>
						<td><?php echo $squadunit['units']['invulnerable_save'];?></td>
						<!--td><?php //echo $squadunit['units']['pts'];?></td-->
						<?php
						} else {
						?>
						<td><?php echo $squadunit['units']['weapon_skill'];?></td>
						<td><?php echo $squadunit['units']['ballistic_skill'];?></td>
						<td><?php echo $squadunit['units']['strength'];?></td>
						<td><?php echo $squadunit['units']['front_armour'];?></td>
						<td><?php echo $squadunit['units']['side_armour'];?></td>
						<td><?php echo $squadunit['units']['rear_armour'];?></td>
						<td><?php echo $squadunit['units']['initiative'];?></td>
						<td><?php echo $squadunit['units']['attacks'];?></td>
						<td><?php echo $squadunit['units']['hull_hitpoints'];?></td>
						<!--td><?php //echo $squadunit['units']['pts'];?></td-->
						<?php
						}
						?>

						<td><?php echo $this->Html->Time("TimeAgo", $squadunit['units']['created']);?></td>
						<td><?php echo $this->Html->Time("TimeAgo", $squadunit['units']['modified']);?></td>
						<td class="actions">
							<?php echo $this->Html->Url($this->Html->__t('View'), array('controller' => 'units', 'action' => 'view', "params" => array($squadunit['units']['id']), "admin" => true), array('class' => 'btn-sm btn-primary')); ?>
							<?php echo $this->Html->Url($this->Html->__t('Edit'), array('controller' => 'units', 'action' => 'edit', "params" => array($squadunit['units']['id']), "admin" => true), array('class' => 'btn-sm btn-warning')); ?>
							<?php echo $this->Html->UrlPost($this->Html->__t('Delete'), array('controller' => 'units', 'action' => 'delete', "params" => array($squadunit['units']['id']), "admin" => true), array('class' => 'btn-sm btn-danger'), $this->Html->__t('Are you sure you want to delete this record?')); ?>
						</td>
					</tr>
				</table>

		<div class="panel-body">

			<div class="row">
				<span class="col-md-3"><?php echo $this->Html->__t("Wargear"); ?></span>
				<span class="col-md-9">
					<ul class="list-group">
					<?php
					if(!empty($squadunit["wargears"])) {

						foreach($squadunit["wargears"] as $wargear) {?>
							<li class="list-group-item"><?php echo $wargear["name"]; ?>
								<span class="pull-right">
									<?php echo $this->Html->Url($this->Html->__t("Edit"), array("controller" => "wargears", "action" => "edit", "admin" => true, "params" => array($wargear['id'])), array("class" => "btn-sm btn-warning")); ?>
								</span>
							</li>
						<?php } ?>
					<?php } else {
						?>
						<li class="list-group-item">None</li>
						<?php
					}
					?>
					</ul>
				</span>
			</div>
			<div class="row">
				<span class="col-md-3"><?php echo $this->Html->__t("Unit Characteristics"); ?></span>
				<span class="col-md-9">
					<ul class="list-group">
					<?php
					if(!empty($squadunit["unitcharacteristics"])) {
						foreach($squadunit["unitcharacteristics"] as $uc) {?>
							<li class="list-group-item"><?php echo $uc["name"]; ?>
								<span class="pull-right">
									<?php echo $this->Html->Url($this->Html->__t("Edit"), array("controller" => "UnitCharacteristics", "action" => "edit", "admin" => true, "params" => array($uc['id'])), array("class" => "btn-sm btn-warning")); ?>
								</span>
							</li>
						<?php }
						} else {
							?>
							<li class="list-group-item">None</li>
							<?php
						}
					?>
					</ul>
				</span>
			</div>
			<div class="row">
				<span class="col-md-3"><?php echo $this->Html->__t("Psyker abilities"); ?></span>
				<span class="col-md-9">
					<ul class="list-group">
					<?php
					if(!empty($squadunit["psykers"])) {
						foreach($squadunit["psykers"] as $py) {?>
							<li class="list-group-item"><?php echo $py["name"]; ?>
								<span class="pull-right">
									<?php echo $this->Html->Url($this->Html->__t("Edit"), array("controller" => "psykers", "action" => "edit", "admin" => true, "params" => array($py['id'])), array("class" => "btn-sm btn-warning")); ?>
								</span>
							</li>
						<?php }
						} else {
							?>
							<li class="list-group-item">None</li>
							<?php
						}
					?>
					</ul>
				</span>
			</div>
			<div class="row">
				<span class="col-md-3"><?php echo $this->Html->__t("Race relics"); ?></span>
				<span class="col-md-9">
					<ul class="list-group">
					<?php
					if(!empty($squadunit["relics"])) {
						foreach($squadunit["relics"] as $rr) {?>
							<li class="list-group-item"><?php echo $rr["name"]; ?>
								<span class="pull-right">
									<?php echo $this->Html->Url($this->Html->__t("Edit"), array("controller" => "psykers", "action" => "edit", "admin" => true, "params" => array($rr['id'])), array("class" => "btn-sm btn-warning")); ?>
								</span>
							</li>
						<?php }
						} else {
							?>
							<li class="list-group-item">None</li>
							<?php
						}
					?>
					</ul>
				</span>
			</div>
			<div class="row">
				<span class="col-md-3"><?php echo $this->Html->__t("Warlord traits"); ?></span>
				<span class="col-md-9">
					<ul class="list-group">
					<?php
					if(!empty($squadunit["warlords"])) {
						foreach($squadunit["warlords"] as $wt) {?>
							<li class="list-group-item"><?php echo $wt["name"]; ?>
								<span class="pull-right">
									<?php echo $this->Html->Url($this->Html->__t("Edit"), array("controller" => "psykers", "action" => "edit", "admin" => true, "params" => array($wt['id'])), array("class" => "btn-sm btn-warning")); ?>
								</span>
							</li>
						<?php }
						} else {
							?>
							<li class="list-group-item">None</li>
							<?php
						}
					?>
					</ul>
				</span>
			</div>
			<div class="row">
				<span class="col-md-3"><?php echo $this->Html->__t("Transport capacity"); ?></span>
				<span class="col-md-9">
					<ul class="list-group">
					<?php
					if(!empty($squadunit["transports"])) {
						foreach($squadunit["transports"] as $tc) {?>
							<li class="list-group-item"><?php echo $tc["name"]; ?>
								<span class="pull-right">
									<?php echo $this->Html->Url($this->Html->__t("Edit"), array("controller" => "psykers", "action" => "edit", "admin" => true, "params" => array($tc['id'])), array("class" => "btn-sm btn-warning")); ?>
								</span>
							</li>
						<?php }
						} else {
							?>
							<li class="list-group-item">None</li>
							<?php
						}
					?>
					</ul>
				</span>
			</div>
			<?php if(isset($squadunit["groups"])) { ?>
				<div class="row">
					<span class="col-md-3"><?php echo $this->Html->__t("Unit Upgrades"); ?></span>
					<span class="col-md-9">
						<?php

							foreach($squadunit["groups"] as $groups) {
									$list = " list-group-item-success";
									if(!isset($groups["min_count"]) && !isset($groups["max_count"])) {
										$list = " list-group-item-danger";
									}
								?>
								<ul class="list-group">
									<li class="list-group-item<?php echo $list;?>"><?php echo $groups["name"]; ?>: Min <?php echo $groups["min_count"]; ?> - Max <?php echo $groups["max_count"]; ?>

										<span class="pull-right">
											<?php echo $this->Html->Url($this->Html->__t("View"), array("controller" => "Groups", "action" => "view", "admin" => true, "params" => array($groups["id"])), array("class" => "btn-sm btn-primary")); ?>
											<?php echo $this->Html->Url($this->Html->__t("Edit"), array("controller" => "UnitGroups", "action" => "edit", "admin" => true, "params" => array($groups["unitgroups_id"], $typ__["data"]["squads"]["id"])), array("class" => "btn-sm btn-warning")); ?>
											<?php echo $this->Html->UrlPost($this->Html->__t("Delete"), array("admin" => true, "controller" => "UnitGroups", "action" => "delete", "params" => array($groups["unitgroups_id"], $typ__["data"]["squads"]["id"])), array("class" => "btn-sm btn-danger"), $this->Html->__t("Are you sure you want to delete this record?")); ?>
										</span>
									</li>
								</ul>
							<?php }
						?>
					</span>
				</div>
			<?php }
			?>

			<div class="row">
				<span class="col-md-3"><?php echo $this->Html->__t("Min Squad count"); ?></span>
				<span class="col-md-9"><?php echo $squadunit["min_count"]; ?></span>
			</div>
			<div class="row">
				<span class="col-md-3"><?php echo $this->Html->__t("Max Squad count"); ?></span>
				<span class="col-md-9"><?php echo $squadunit["max_count"]; ?></span>
			</div>
			<div class="row">
				<span class="col-md-3"><?php echo $this->Html->__t("Unit type"); ?></span>
				<span class="col-md-9"><?php echo $squadunit["units"]["unittype"]; ?></span>
			</div>
			<div class="row">
				<span class="col-md-3"><?php echo $this->Html->__t("Created"); ?></span>
				<span class="col-md-9"><?php echo $this->Html->Time("TimeAgo", $squadunit["created"]); ?></span>
			</div>
			<div class="row">
				<span class="col-md-3"><?php echo $this->Html->__t("Modified"); ?></span>
				<span class="col-md-9"><?php echo $this->Html->Time("TimeAgo", $squadunit["modified"]); ?></span>
			</div>
		</div>
	</div>
</div>
<?php
	}
}
?>
